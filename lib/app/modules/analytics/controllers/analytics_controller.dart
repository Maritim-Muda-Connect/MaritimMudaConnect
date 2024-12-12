import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    analyticService = Get.put(AnalyticService());
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
    selectedMonth.value = months.isNotEmpty ? months[0] : '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAnalytics();
    });
  }

  Future<void> fetchAnalytics() async {
    isLoading.value = true;
    try {
      final response = await analyticService.fetchAnalytics();

      months.value = response.months ?? [];
      widgets.value = response.widgets ?? [];
      userCounts.value = response.userCounts!.values.toList();
      announcement.value = response.announcement ?? "No announcement";

      if (months.isNotEmpty && selectedMonth.value.isEmpty) {
        selectedMonth.value = months[0];
      }
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
