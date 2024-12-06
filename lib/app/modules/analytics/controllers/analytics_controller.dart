import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/analytics/analytic_service.dart';
import '../../../data/models/response/analytic_response.dart';

class AnalyticsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var isLoading = false.obs;
  var selectedIndex = 0.obs;
  var selectedMonth = ''.obs;
  var userCounts = <int>[].obs;
  var months = <String>[].obs;
  var widgets = <Widgets>[].obs;
  var announcement = ''.obs;

  var svgPaths = [
    'assets/icons/member_icon.svg',
    'assets/icons/event_icon.svg',
    'assets/icons/scholarship_icon.svg',
    'assets/icons/job_icon.svg',
  ];

  late AnalyticService analyticService;
  String? token;

  @override
  void onInit() async {
    super.onInit();

    // Inisialisasi AnalyticService dengan Get.put() atau Get.lazyPut()
    analyticService = Get.put(AnalyticService());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token'); // Ambil token dari SharedPreferences

    if (token == null || token!.isEmpty) {
      // Token belum ada, mungkin tampilkan snackbar atau redirect ke login
      Get.snackbar('Error', 'Token is required to fetch analytics data');
      return;
    }

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });

    // Set default bulan pertama
    selectedMonth.value = months.isNotEmpty ? months[0] : '';

    // Menunda eksekusi untuk fetchAnalytics
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAnalytics(); // Menunggu hingga build selesai
    });
  }

  Future<void> fetchAnalytics() async {
    if (token == null || token!.isEmpty) {
      Get.snackbar('Error', 'Token is required to fetch analytics data');
      return;
    }

    isLoading.value = true;
    try {
      final response = await analyticService.fetchAnalytics();

      // Set state dengan data yang diterima
      months.value = response.months ?? [];
      widgets.value = response.widgets ?? [];
      userCounts.value = response.userCounts!.values.toList();
      announcement.value = response.announcement ?? "No announcement";

      // Set default bulan jika belum dipilih
      if (months.isNotEmpty && selectedMonth.value.isEmpty) {
        selectedMonth.value = months[0];
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch analytics: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
