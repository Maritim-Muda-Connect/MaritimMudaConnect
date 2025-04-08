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

  final selectedRange = "All Time".obs;
  final timeRanges = [
    "All Time",
    "Last 6 Months",
    "Last 12 Months",
  ];
  final _allMonths = <String>[].obs;
  final _allUserCounts = <int>[].obs;

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

      // Store full data
      _allMonths.value = response.months ?? [];
      _allUserCounts.value = response.userCounts!.values.toList();

      // Store other data
      widgets.value = response.widgets ?? [];
      announcement.value = response.announcement ?? "No announcement";

      // Apply initial filtering
      changeTimeRange(selectedRange.value);
    } finally {
      isLoading.value = false;
    }
  }

  void changeTimeRange(String range) {
    selectedRange.value = range;

    if (_allMonths.isEmpty) return;

    int monthsToShow;
    switch (range) {
      case 'Last 6 Months':
        monthsToShow = 6;
        break;
      case 'Last 12 Months':
        monthsToShow = 12;
        break;
      case 'All Time':
      default:
        monthsToShow = _allMonths.length;
        break;
    }
    months.value = _allMonths.take(monthsToShow).toList();
    userCounts.value = _allUserCounts.take(monthsToShow).toList();

    // Update selected month if needed
    if (months.isNotEmpty && !months.contains(selectedMonth.value)) {
      selectedMonth.value = months[0];
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
