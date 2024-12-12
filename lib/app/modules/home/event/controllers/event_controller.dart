import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/event_response.dart';
import 'package:maritimmuda_connect/app/data/services/home/event_service.dart';
import 'package:maritimmuda_connect/app/modules/home/event/views/category_event.dart';
import 'package:maritimmuda_connect/app/modules/home/event/views/list_event_view.dart';

class EventController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final scrollController = ScrollController();
  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var eventsList = <Event>[].obs;
  var searchQuery = "".obs;
  var filterEventList = <Event>[].obs;
  var sortedEventList = <Event>[].obs;
  var selectedFilter = 'A - Z'.obs;
  var isFabVisible = false.obs;

  List<String> title = [
    'All',
    'Competetion',
    'Seminar',
    'Environment Action',
    'Forum',
    'Training',
    'Community Development'
  ];

  List<Widget> screens = [
    const ListEventView(),
    const CategoryEvent(),
    const CategoryEvent(),
    const CategoryEvent(),
    const CategoryEvent(),
    const CategoryEvent(),
    const CategoryEvent(),
  ];

  List<Event> getFiveLatestEvents() {
    var sortedEvents = eventsList
        .where(
            (event) => event.posterLink != null && event.posterLink!.isNotEmpty)
        .toList();

    sortedEvents.sort((a, b) => (b.createdAt ?? DateTime.now())
        .compareTo(a.createdAt ?? DateTime.now()));

    return sortedEvents.take(5).toList();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 7, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
      sortEventsByType(getTypeForTab(selectedIndex.value));
    });
    getAllEvents();
    scrollController.addListener(() {
      if (scrollController.position.pixels > 400) {
        isFabVisible(true);
      } else {
        isFabVisible(false);
      }
    });
  }

  void getAllEvents() async {
    try {
      isLoading.value = true;
      var response = await EventService().getAllEvents();
      eventsList.assignAll(response);
      eventsList.sort((a, b) => (b.startDate ?? DateTime.now())
          .compareTo(a.startDate ?? DateTime.now()));
      filterEventList.assignAll(eventsList);
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int getTypeForTab(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return 4;
      case 2:
        return 1;
      case 3:
        return 8;
      case 4:
        return 3;
      case 5:
        return 7;
      case 6:
        return 5;
      default:
        return 0;
    }
  }

  void searchEvents(String query) {
    searchQuery.value = query;
    var tempList = List<Event>.from(eventsList);

    if (searchQuery.value.isNotEmpty) {
      tempList = tempList.where((event) {
        final nameMatch = event.name
                ?.toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ??
            false;
        final organizerMatch = event.organizerName
                ?.toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ??
            false;
        return nameMatch || organizerMatch;
      }).toList();
    }

    filterEventList.assignAll(tempList);

    sortedEventList.assignAll(tempList);
  }

  void sortEventsByType(int type) {
    var sortedList = eventsList.where((event) => event.type == type).toList();
    sortedEventList.assignAll(type == 0 ? eventsList : sortedList);
  }

  final filterOptions = ['Sort By:', 'A - Z', 'Newest', 'Oldest'];
  dynamic updateFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void applyFilter() {
    List<Event>? sortedList;
    if (selectedIndex.value == 0) {
      sortedList = List<Event>.from(filterEventList);
    } else {
      sortedList = eventsList
          .where((event) => event.type == getTypeForTab(selectedIndex.value))
          .toList();
    }

    if (selectedFilter.value == 'A - Z') {
      sortedList.sort((a, b) => ((a.name) ?? "").compareTo(b.name ?? ""));
    } else if (selectedFilter.value == 'Newest') {
      sortedList.sort((a, b) => (b.startDate ?? DateTime.now())
          .compareTo(a.startDate ?? DateTime.now()));
    } else if (selectedFilter.value == 'Oldest') {
      sortedList.sort((a, b) => (a.startDate ?? DateTime.now())
          .compareTo(b.startDate ?? DateTime.now()));
    }

    if (selectedIndex.value == 0) {
      filterEventList.assignAll(sortedList);
    } else {
      sortedEventList.assignAll(sortedList);
    }
  }

  void setSelectedIndex(int index) {
    tabController.index = index;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
