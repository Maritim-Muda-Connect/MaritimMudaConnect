import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/response/uid_response.dart';
import 'package:maritimmuda_connect/app/data/services/home/member_service.dart';
import '../../../../data/models/response/member_response.dart';
import '../../../../data/utils/province.dart';

class MemberController extends GetxController {
  final scrollController = ScrollController();
  final expandedSections = <String, bool>{}.obs;
  final selectedItems = <String, String>{}.obs;
  DateTime? emailVerified;

  var isVisible = false.obs;
  var isLoading = false.obs;
  var memberList = <Member>[].obs;
  var filteredMemberList = <Member>[].obs;
  var memberData = UidResponse().obs;
  var searchQuery = ''.obs;
  var isDrawerVisible = false.obs;
  var dateOfBirth = ''.obs;
  var isFabVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllMember();
    scrollController.addListener(() {
      if (scrollController.position.pixels > 1000) {
        isFabVisible(true);
      } else {
        isFabVisible(false);
      }
    });
  }

  Future<void> getEmail(String email) async {
    isLoading(true);
    try {
      var response = await MemberService().getEmail(email);
      memberData(response);
      emailVerified = response.user?.emailVerifiedAt;
      dateOfBirth(response.user?.dateOfBirth != null
          ? DateFormat('dd MMMM yyyy').format(response.user!.dateOfBirth!)
          : '');
    } catch (e) {
      print("Error fetching email: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAllMember() async {
    try {
      isLoading.value = true;
      var response = await MemberService().getAllMembers();
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

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
