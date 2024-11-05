import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/scholarship_response.dart';
import 'package:maritimmuda_connect/app/data/services/scholarship_service.dart';

class ScholarshipController extends GetxController
  with GetSingleTickerProviderStateMixin {

  final count = 0.obs;
  var isLoading = false.obs;
  var scholarshipList = <Scholarship>[].obs;
  var searchQuery = "".obs;
  var filteredList = <Scholarship>[].obs;
  var selectedFilter = "A - Z".obs;

  @override
  void onInit() {
    super.onInit();
    getAllScholarships();
  }

  void getAllScholarships() async {
    try {
      isLoading.value = true;
      var response = await ScholarshipService().getAllScholarship();
      scholarshipList.assignAll(response);
      filteredList.assignAll(scholarshipList);
    } catch (e) {
      print("Error fetch Scholarships");
    } finally {
      isLoading.value = false;
    }
  }


  void searchScholarship(String query) {
    searchQuery.value = query;
    var tempList = List<Scholarship>.from(scholarshipList);
    if (searchQuery.value.isNotEmpty) {
      tempList = tempList.where((scholar) {
        final matchName = scholar.name?.toLowerCase().contains(
            searchQuery.value.toLowerCase()
        ) ?? false;
        final matchProvider = scholar.providerName?.toLowerCase().contains(
            searchQuery.value.toLowerCase()
        ) ?? false;
        return matchName || matchProvider;
      }).toList();
    }

    filteredList.assignAll(tempList);

  }

  final filterOptions =  ["Urutkan Berdasarkan", "A - Z", "Terdekat", "Terlama"];
  void updateFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void applyFilter() {
    var sortedList = List<Scholarship>.from(filteredList);
    if(selectedFilter.value == "A - Z") {
      sortedList.sort((a,b) =>
          (a.name ?? "").compareTo(b.name ?? "")
      );
    } else if (selectedFilter.value == "Terdekat") {
      sortedList.sort((a,b) =>
          (b.submissionDeadline ?? DateTime.now()).compareTo(a.submissionDeadline ?? DateTime.now())
      );
    } else if (selectedFilter.value == "Terlama") {
      sortedList.sort((a,b) =>
          (a.submissionDeadline ?? DateTime.now()).compareTo(b.submissionDeadline ?? DateTime.now())
      );
    }

    filteredList.assignAll(sortedList);
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
