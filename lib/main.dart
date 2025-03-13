import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'app/routes/app_pages.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        _launchURL(response.payload!);
      }
    },
  );

  await requestNotificationPermission();
  await checkNewUpdates();
  startPeriodicEventCheck();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width > 600) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Maritim Muda Connect",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}

Future<void> _sendNotificationIfNew(SharedPreferences prefs, dynamic item, String key, String title, String type) async {
  int itemId = int.tryParse(item['id'].toString()) ?? 0;
  int? savedItemId = prefs.getInt(key);

  if (savedItemId == null || savedItemId != itemId) {
    String jobTitle = item['position_title'] ?? item['name'] ?? 'Lowongan Baru';
    String company = item['company_name'] ?? '';
    String posterUrl = item['poster_link'] ?? '';
    String externalUrl = item['link'] ?? item['external_url'] ?? item['registration_link'] ?? '';

    print("🔔 Notifikasi dikirim: $title - $jobTitle di $company");

    await showNotification("$title: $jobTitle", type == 'job' ? '' : posterUrl, externalUrl);
    await Future.delayed(Duration(seconds: 2));
    await prefs.setInt(key, itemId);
  } else {
    print("✅ Tidak ada $title baru.");
  }
}

Future<void> showNotification(String title, String imageUrl, String externalUrl) async {
  try {
    String? imagePath;
    if (imageUrl.isNotEmpty && Uri.tryParse(imageUrl)?.hasAbsolutePath == true) {
      imagePath = await _downloadAndSaveFile(imageUrl, 'notification_poster.jpg');
    }

    final BigPictureStyleInformation? bigPictureStyle = imagePath != null
        ? BigPictureStyleInformation(FilePathAndroidBitmap(imagePath),
            contentTitle: title, summaryText: 'Klik untuk info lebih lanjut!')
        : null;

    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'general_channel_id',
      'Notifikasi Umum',
      channelDescription: 'Notifikasi untuk semua update terbaru',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      styleInformation: bigPictureStyle,
      icon: '@drawable/ic_notification',
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      'Klik untuk info lebih lanjut!',
      platformChannelSpecifics,
      payload: externalUrl.isNotEmpty ? externalUrl : null,
    );
  } catch (e) {
    print("❌ Gagal menampilkan notifikasi: $e");
  }
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final Uint8List bytes = response.bodyBytes;
  final File file = File(filePath);
  await file.writeAsBytes(bytes);
  return filePath;
}

void _launchURL(String url) async {
  Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print('❌ Tidak dapat membuka URL: $url');
  }
}

Future<void> requestNotificationPermission() async {
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  if (androidImplementation != null) {
    final bool? granted = await androidImplementation.requestNotificationsPermission();
    if (granted == true) {
      print("✅ Izin notifikasi diberikan.");
    } else {
      print("❌ Izin notifikasi ditolak.");
    }
  }
}

Future<void> checkNewUpdates() async {
  final prefs = await SharedPreferences.getInstance();
  final dio = Dio();

  final List<Map<String, String>> endpoints = [
    {
      "url": "https://hub.maritimmuda.id/api/events?draw=1&length=10",
      "type": "event",
      "key": "latest_event_id",
      "title": "Event Baru! 🎉"
    },
    {
      "url": "https://hub.maritimmuda.id/api/scholarships?draw=1&length=10",
      "type": "scholarship",
      "key": "latest_scholarship_id",
      "title": "Beasiswa Baru! 🎓"
    },
    {
      "url": "https://hub.maritimmuda.id/api/job-posts?draw=1&length=10",
      "type": "job",
      "key": "latest_job_id",
      "title": "Lowongan Baru! 💼"
    }
  ];

  try {
    for (var endpoint in endpoints) {
      final response = await dio.get(
        endpoint["url"]!,
        options: Options(
          headers: {
            "Authorization": "Bearer 288|yO2xzgkghovhg1ldpeTK3fzrfZKqJq4nEmASKcNt",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        List<dynamic> items = _parseAndSortData(data);

        if (items.isNotEmpty) {
          final latestItem = items[0];
          await _sendNotificationIfNew(prefs, latestItem, endpoint["key"]!, endpoint["title"]!, endpoint["type"]!);
        }
      } else {
        print("❌ Gagal mengambil data ${endpoint["type"]}, Status Code: ${response.statusCode}");
      }
    }
  } catch (e) {
    print('❌ Error fetching updates: $e');
  }
}

List<dynamic> _parseAndSortData(dynamic data) {
  List<dynamic> items;
  if (data is List) {
    items = data;
  } else if (data is Map<String, dynamic> && data.containsKey('data')) {
    items = data['data'];
  } else {
    print("⚠️ Format data tidak sesuai.");
    return [];
  }

  items.sort((a, b) {
    DateTime dateA = DateTime.tryParse(a['created_at'] ?? '') ?? DateTime(1970);
    DateTime dateB = DateTime.tryParse(b['created_at'] ?? '') ?? DateTime(1970);
    return dateB.compareTo(dateA);
  });

  return items;
}

void startPeriodicEventCheck() {
  Timer.periodic(const Duration(hours: 1), (timer) {
    checkNewUpdates();
  });
}
