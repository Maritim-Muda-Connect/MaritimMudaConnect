// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:maritimmuda_connect/app/data/services/home_service.dart';

// import '../../../../data/models/response/member_response.dart';
// import '../../../../data/utils/province.dart';

// class MemberController extends GetxController {
//   var isVisible = false.obs;
//   var isLoading = false.obs;
//   // Observable map to track which sections are expanded
//   final expandedSections = <String, bool>{}.obs;

//   var memberList = <Member>[].obs;

//   // New variables
//   var searchQuery = ''.obs;
//   var filteredMemberList = <Member>[].obs;

//   // Observable map to store selected items for each section
//   final selectedItems = <String, String>{}.obs;

//   var isDraweVisible = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getAllMember();
//     filteredMemberList.value = memberList;
//   }

//   String getFormattedDate(DateTime? date) {
//     if (date == null) return '-';
//     return DateFormat('MMMM yyyy', 'id_ID').format(date);
//   }

//   // List of available provinces
//   final provinces = [
//     "Jawa Barat",
//     "Bali",
//     "Jawa Timur",
//     "Sumatera Utara",
//     "Sulawesi Selatan"
//   ].obs;

//   // List of available expertises
//   final expertises = [
//     "Maen Basket",
//     "Nguli",
//     "Pemrograman",
//     "Desain Grafis",
//     "Manajemen Proyek"
//   ].obs;

//   void getAllMember() async {
//     try {
//       isLoading.value = true;
//       var response = await HomeService().getAllMembers();
//       memberList.assignAll(response.members!);
//     } catch (e) {
//       print("INI ERROR ICLIK $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   //  search method
//   void searchMembers(String query) {
//     searchQuery.value = query;
//     if (query.isEmpty) {
//       filteredMemberList.value = memberList;
//     } else {
//       filteredMemberList.value = memberList.where((member) {
//         final nameMatch =
//             member.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
//         final provinceMatch = provinceOptions[member.provinceId.toString()]
//             ?.toLowerCase()
//             .contains(query.toLowerCase());
//         return nameMatch || provinceMatch!;
//       }).toList();
//     }
//   }

//   // Toggle the expansion state of a section
//   void toggleSection(String title) {
//     expandedSections[title] = !(expandedSections[title] ?? false);
//   }

//   // Set the selected province
//   void setSelectedProvince(String value) {
//     selectedItems['Province'] = value;
//     update(); // Notify listeners about the change
//   }

//   // Set the selected expertise
//   void setSelectedExpertise(String value) {
//     selectedItems['Expertise'] = value;
//     update(); // Notify listeners about the change
//   }

//   // Get the selected province
//   String? get selectedProvince => selectedItems['Province'];

//   // Get the selected expertise
//   String? get selectedExpertise => selectedItems['Expertise'];

//   // Apply filters (you can extend this method based on your needs)
//   void applyFilters() {
//     // Implement your filter logic here
//     print(
//         'Applying filters: Province - ${selectedProvince}, Expertise - ${selectedExpertise}');
//     // You might want to fetch filtered data from an API or filter local data
//     // Then update your UI accordingly
//   }

//   // Reset all filters
//   void resetFilters() {
//     selectedItems.clear();
//     update(); // Notify listeners about the change
//   }

//   // Add a new province to the list
//   void addProvince(String province) {
//     if (!provinces.contains(province)) {
//       provinces.add(province);
//     }
//   }

//   // Add a new expertise to the list
//   void addExpertise(String expertise) {
//     if (!expertises.contains(expertise)) {
//       expertises.add(expertise);
//     }
//   }

//   void visibleToggle() {
//     // isVisible.toggle();
//     isVisible.value = !isVisible.value;
//     // print(isVisible.value);
//   }
// }

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/services/home_service.dart';
import '../../../../data/models/response/member_response.dart';
import '../../../../data/utils/province.dart';

class MemberController extends GetxController {
  var isVisible = false.obs;
  var isLoading = false.obs;
  final expandedSections = <String, bool>{}.obs;
  var memberList = <Member>[].obs;
  var filteredMemberList = <Member>[].obs;
  var searchQuery = ''.obs;
  final selectedItems = <String, String>{}.obs;
  var isDrawerVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllMember();
  }

  void getAllMember() async {
    try {
      isLoading.value = true;
      var response = await HomeService().getAllMembers();
      memberList.assignAll(response.members!);
      // Initialize filtered list with all members
      filteredMemberList.assignAll(memberList);
    } catch (e) {
      print("Error fetching members: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchMembers(String query) {
    searchQuery.value = query;
    applyFilters(); // Apply both search and filters
  }

  void toggleSection(String title) {
    expandedSections[title] = !(expandedSections[title] ?? false);
  }

  void setSelectedProvince(String value) {
    if (selectedItems['Province'] == value) {
      selectedItems.remove('Province'); // Deselect if already selected
    } else {
      selectedItems['Province'] = value;
    }
    applyFilters();
  }

  void setSelectedExpertise(String value) {
    if (selectedItems['Expertise'] == value) {
      selectedItems.remove('Expertise'); // Deselect if already selected
    } else {
      selectedItems['Expertise'] = value;
    }
    applyFilters();
  }

  void applyFilters() {
    var tempList = List<Member>.from(memberList);

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      tempList = tempList.where((member) {
        final nameMatch = member.name
                ?.toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ??
            false;
        final provinceMatch = provinceOptions[member.provinceId.toString()]
            ?.toLowerCase()
            .contains(searchQuery.value.toLowerCase());
        return nameMatch || provinceMatch!;
      }).toList();
    }

    // Apply province filter
    if (selectedItems.containsKey('Province')) {
      tempList = tempList.where((member) {
        return member.provinceId.toString() == selectedItems['Province'];
      }).toList();
    }

    // Apply expertise filter
    if (selectedItems.containsKey('Expertise')) {
      tempList = tempList.where((member) {
        return member.firstExpertiseId.toString() ==
                selectedItems['Expertise'] ||
            member.secondExpertiseId.toString() == selectedItems['Expertise'];
      }).toList();
    }

    filteredMemberList.assignAll(tempList);
  }

  void resetFilters() {
    selectedItems.clear();
    searchQuery.value = '';
    filteredMemberList.assignAll(memberList);
  }

  String getFormattedDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('MMMM yyyy', 'id_ID').format(date);
  }
}
