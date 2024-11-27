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

   Future <void> getAllMember() async {
    try {
      isLoading.value = true;
      var response = await HomeService().getAllMembers();
      memberList.assignAll(response.members!);
      filteredMemberList.assignAll(memberList);
    } catch (e) {
      print("Error fetching members: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchMembers(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void toggleSection(String title) {
    expandedSections[title] = !(expandedSections[title] ?? false);
  }

  void setSelectedProvince(String value) {
    if (selectedItems['Province'] == value) {
      selectedItems.remove('Province');
    } else {
      selectedItems['Province'] = value;
    }
    applyFilters();
  }

  void setSelectedExpertise(String value) {
    if (selectedItems['Expertise'] == value) {
      selectedItems.remove('Expertise');
    } else {
      selectedItems['Expertise'] = value;
    }
    applyFilters();
  }

  void applyFilters() {
    var tempList = List<Member>.from(memberList);

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

    if (selectedItems.containsKey('Province')) {
      tempList = tempList.where((member) {
        return member.provinceId.toString() == selectedItems['Province'];
      }).toList();
    }

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
