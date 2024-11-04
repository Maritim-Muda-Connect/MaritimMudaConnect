import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:maritimmuda_connect/app/data/models/request/work_experiences_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/work_experiences_response.dart';
import 'package:maritimmuda_connect/app/data/services/work_experiences_service.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';

class WorkExperiencesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  Rx<int?> selectedMonth = Rx<int?>(null);
  Rx<int?> selectedYear = Rx<int?>(null);

  var isLoading = false.obs;
  var workExperienceLists = <WorkExperiencesResponse>[].obs;
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
    fetchWorkExperiences();
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

  void patchField(WorkExperiencesResponse workExperiencesData) {
    positionController.text = workExperiencesData.positionTitle ?? '';
    institutionController.text = workExperiencesData.companyName ?? '';
    startDateController.text = formatDate(workExperiencesData.startDate);
    endDateController.text = formatDate(workExperiencesData.endDate);
    selectedStartDate.value = DateTime.parse(workExperiencesData.startDate.toString());
    selectedEndDate.value = DateTime.parse(workExperiencesData.endDate.toString());
  }

  void fetchWorkExperiences() async {
    try {
      isLoading.value = true;
      var data = await WorkExperiencesService().fetchWorkExperiences();
      workExperienceLists.assignAll(data);
    } catch (e) {
      print (e);
    } finally {
      isLoading.value = false;
    }
  }

  void createWorkExperience(WorkExperiencesRequest request) async {
    print(request.toJson());
    try {
      isLoading.value = true;
      bool success = await WorkExperiencesService().createWorkExperience(request);

      if (success) {
        fetchWorkExperiences();
        clearAll();
        customSnackbar(
          'Success Adding Work Experience!'
        );
      } else {
        customSnackbar(
          'Failed Adding Work Experience!'
        );
      }
    } catch (e) {
      print (e);
    } finally {
      isLoading.value = false;
    }
  }

  void updateWorkExperience(WorkExperiencesRequest request, int id) async {
    try {
      isLoading.value = true;
      bool success = await WorkExperiencesService().updateWorkExperience(request, id);

      if (success) {
        fetchWorkExperiences();
        clearAll();
        customSnackbar(
            'Success Updating Work Experience!'
        );
      } else {
        customSnackbar(
            'Failed Updating Work Experience!'
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void deleteWorkExperience(int id) async {
    try {
      isLoading.value = true;
      bool success = await WorkExperiencesService().deleteWorkExperiences(id);

      if (success) {
        fetchWorkExperiences();
        clearAll();
        customSnackbar(
            'Success Deleting Work Experience!'
        );
      } else {
        customSnackbar(
            'Failed Deleting Work Experience!'
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void clearAll() {
    positionController.clear();
    institutionController.clear();
    startDateController.clear();
    endDateController.clear();
    selectedStartDate.value = null;
    selectedEndDate.value = null;
  }

  @override
  void onClose() {
    super.onClose();
    positionController.dispose();
    institutionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}