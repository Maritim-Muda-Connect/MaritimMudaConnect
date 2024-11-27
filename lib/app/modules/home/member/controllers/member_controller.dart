import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/services/home_service.dart';
import '../../../../data/models/response/member_response.dart';
import '../../../../data/services/config.dart';
import '../../../../data/utils/province.dart';
import 'package:http/http.dart' as http;

class MemberController extends GetxController {
  var isVisible = false.obs;
  var isLoading = false.obs;
  final expandedSections = <String, bool>{}.obs;
  var memberList = <Member>[].obs;
  var filteredMemberList = <Member>[].obs;
  var searchQuery = ''.obs;
  final selectedItems = <String, String>{}.obs;
  var isDrawerVisible = false.obs;
  DateTime? emailVerifiedAt;

  @override
  void onInit() {
    super.onInit();
    getAllMember();
  }

  void getEmail(String email) async {
    isLoading.value = true;
    final response =
        await http.get(Uri.parse("$baseUrl/user/$email/check-uid"));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        final emailVerifiedAtString = jsonResponse['user']['email_verified_at'];
        emailVerifiedAt = DateTime.parse(emailVerifiedAtString);
        isLoading.value = false;
      } else {
        print('Error: ${jsonResponse['error']}');
      }
    } else {
      print('Error fetching data: ${response.statusCode}');
    }
  }

  Future<void> getAllMember() async {
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
