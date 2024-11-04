import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/request/social_activity_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/social_activity_response.dart';
import 'package:maritimmuda_connect/app/data/services/social_activity_service.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../../../widget/custom_snackbar.dart';


class SocialActivityController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController programController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  Rx<int?> selectedMonth = Rx<int?>(null);
  Rx<int?> selectedYear = Rx<int?>(null);

  var isLoading = false.obs;
  var socialActivityLists = <SocialActivityResponse>[].obs;
  var isEdit = false.obs;
  var idCard = 0.obs;

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('MMMM yyyy').format(date) : '';
  }

  String get formattedMonthYear {
    return DateFormat('MMMM yyyy')
        .format(DateTime(selectedYear.value!, selectedMonth.value!));
  }

  String formatDateRequest(DateTime date) {
    return DateFormat('yyyy-MM').format(date);
  }

  @override
  void onInit() {
    super.onInit();
    fetchSocialActivity();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future<void> selectStartDate(BuildContext context) async {
    showMonthPicker(
      context,
      initialSelectedMonth: selectedMonth.value ?? DateTime.now().month,
      initialSelectedYear: selectedYear.value ?? DateTime.now().year,
      firstYear: 1900,
      lastYear: DateTime.now().year,
      selectButtonText: 'OK',
      cancelButtonText: 'Cancel',
      highlightColor: primaryBlueColor,
      textColor: Colors.black,
      contentBackgroundColor: neutral01Color,
      dialogBackgroundColor: Colors.white,
      onSelected: (month, year) {
        selectedMonth.value = month;
        selectedYear.value = year;
        startDateController.text = formattedMonthYear;
        selectedStartDate.value =
            DateTime(selectedYear.value!, selectedMonth.value!);
      },
    );
  }

  Future<void> selectEndDate(BuildContext context) async {
    showMonthPicker(
      context,
      initialSelectedMonth: selectedMonth.value ?? DateTime.now().month,
      initialSelectedYear: selectedYear.value ?? DateTime.now().year,
      firstYear: 1900,
      lastYear: DateTime.now().year,
      selectButtonText: 'OK',
      cancelButtonText: 'Cancel',
      highlightColor: primaryBlueColor,
      textColor: Colors.black,
      contentBackgroundColor: Colors.white,
      dialogBackgroundColor: neutral01Color,
      onSelected: (month, year) {
        selectedMonth.value = month;
        selectedYear.value = year;
        endDateController.text = formattedMonthYear;
        selectedEndDate.value =
            DateTime(selectedYear.value!, selectedMonth.value!);
      },
    );
  }

  void patchField(SocialActivityResponse socialActivityData){
    programController.text = socialActivityData.name ?? '';
    institutionController.text = socialActivityData.institutionName ?? '';
    roleController.text = socialActivityData.role ?? '';
    startDateController.text = formatDate(socialActivityData.startDate);
    endDateController.text = formatDate(socialActivityData.endDate);
    selectedStartDate.value = DateTime.parse(socialActivityData.startDate.toString());
    selectedEndDate.value = DateTime.parse(socialActivityData.endDate.toString());
  }

  Future <void> fetchSocialActivity() async {
    try{
      isLoading.value = true;
      var data = await SocialActivityService().fetchSocialActivity();
      socialActivityLists.assignAll(data);
    } catch (e){
      print(e);
    }finally{
      isLoading.value = false;
    }
  }

  void createSocialActivity(SocialActivityRequest request) async {
    print(request.toJson());
    try{
      isLoading.value = true;
      bool success = await SocialActivityService().createSocialActivity(request);

      if (success){
        fetchSocialActivity();
        clearAll();
        customSnackbar(
          'Success Adding Social Activity History!',
        );
      } else {
        customSnackbar(
          'Failed Adding Social Activity History!',
        );
      }
    } catch (e){
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSocialActivity(SocialActivityRequest request, int id) async{
    try{
      isLoading.value = true;
      bool success = await SocialActivityService().updateSocialActivity(request, id);

      if (success){
        fetchSocialActivity();
        clearAll();
        customSnackbar(
          'Success Updating Social Activity History !',
        );
      } else {
        customSnackbar(
          'Failed Updating Social Activity History !'
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void deleteSocialAcitivty(int id) async {
    try {
      isLoading.value = true;
      bool success = await SocialActivityService().deleteSocialActivity(id);

      if (success) {
        fetchSocialActivity();
        customSnackbar(
          'Success Deleting social activity history!',
          null,
          const Duration(milliseconds: 800),
        );
      } else {
        customSnackbar(
          'Failed Deleting social activity history!',
          secondaryRedColor,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void clearAll(){
    programController.clear();
    institutionController.clear();
    roleController.clear();
    startDateController.clear();
    endDateController.clear();
    selectedStartDate.value = null;
    selectedEndDate.value = null;
  }

  @override
  void onClose(){
    super.onClose();
    programController.dispose();
    institutionController.dispose();
    roleController.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}