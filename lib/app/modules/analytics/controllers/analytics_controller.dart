import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var selectedIndex = 0.obs;

  var selectedMonth = 'January'.obs;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<String> title = [
    'Members',
    'Events',
    'Scholarships',
    'Jobs',
  ];

  final List<String> titleMenu = [
    'About Growth',
    'About Events',
    'About Scholarships',
    'About Jobs',
  ];

  final List<List<Map<String, dynamic>>> tabCardsData = [
    [
      {
        'title': 'Member Growth',
        'icon': Icons.rocket_launch,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Member Retention',
        'icon': Icons.bar_chart,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'New Members',
        'icon': Icons.person_add,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Active Members',
        'icon': Icons.groups,
        'image': 'assets/images/chart.svg',
      },
    ],
    [
      {
        'title': 'Event Attendance',
        'icon': Icons.event,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Event Participation',
        'icon': Icons.group_work,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Upcoming Events',
        'icon': Icons.calendar_today,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Event Engagement',
        'icon': Icons.handshake,
        'image': 'assets/images/chart.svg',
      },
    ],
    [
      {
        'title': 'Scholarship Applications',
        'icon': Icons.school,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Scholarship Approval',
        'icon': Icons.check_circle,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Scholarship Trends',
        'icon': Icons.trending_up,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Scholarship Recipients',
        'icon': Icons.emoji_events,
        'image': 'assets/images/chart.svg',
      },
    ],
    [
      {
        'title': 'Job Listings',
        'icon': Icons.work,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Job Applications',
        'icon': Icons.assignment_ind,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Job Offers',
        'icon': Icons.how_to_reg,
        'image': 'assets/images/chart.svg',
      },
      {
        'title': 'Job Trends',
        'icon': Icons.show_chart,
        'image': 'assets/images/chart.svg',
      },
    ]
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: title.length, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
