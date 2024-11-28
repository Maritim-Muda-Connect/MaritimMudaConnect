import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:maritimmuda_connect/app/data/services/config.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/utils/user_preference.dart';

class EKtaController extends GetxController {
  final RxInt currentPage = 0.obs;
  final String defaultAvatar =
      "https://static.vecteezy.com/system/resources/previews/009/292/244/non_2x/default-avatar-icon-of-social-media-user-vector.jpg";
  var sliderValue = 0.0.obs;
  var ektaImage = ''.obs;
  var displayName = ''.obs;
  var urlDownloaded = ''.obs;

  void updateSliderValue(double value) {
    sliderValue.value = value;
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    getEkta();
  }

  void getEkta() async {
    try {
      String? token = await UserPreferences().getToken();
      String? name = await UserPreferences().getName();

      displayName.value = name!;
      final response = await http.get(
        Uri.parse("$baseUrl/profile/general"),
        headers: headerWithToken(token!),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final membercard = data['user']['member-card-preview_link'];
        ektaImage.value = membercard;

        final urlLink = data['user']['member-card-document_link'];
        urlDownloaded.value = urlLink;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception("Could not launch $url)");
    }
  }
}
