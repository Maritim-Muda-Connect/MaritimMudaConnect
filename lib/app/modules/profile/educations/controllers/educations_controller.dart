import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/request/educations_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/educations_response.dart';
import 'package:maritimmuda_connect/app/data/services/educations_service.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';

class EducationsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final institutionController = TextEditingController();
  final majorController = TextEditingController();
  final levelController = TextEditingController();
  final gradController = TextEditingController();

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<int?> selectedMonth = Rx<int?>(null);
  Rx<int?> selectedYear = Rx<int?>(null);

  var isLoading = false.obs;
  var educationList = <EducationsResponse>[].obs;
  var isEdit = false.obs;
  var idCard = 0.obs;

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('MMMM yyyy').format(date) : '';
  }

  String get formattedMonthYear {
    if (selectedMonth.value != null && selectedYear.value != null) {
      return DateFormat('MMMM yyyy')
          .format(DateTime(selectedYear.value!, selectedMonth.value!));
    } else {
      return '';
    }
  }

  String formatDateRequest(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  void onInit() {
    super.onInit();
    fetchEducations();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future<void> selectDate(BuildContext context) async {
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
        gradController.text = formattedMonthYear;
        selectedDate.value =
            DateTime(selectedYear.value!, selectedMonth.value!);
      },
    );
  }

  void patchField(EducationsResponse educationsData) {
    institutionController.text = educationsData.institutionName ?? '';
    majorController.text = educationsData.major ?? '';
    String levelText = getLevelText(educationsData.level);
    selectedLevel.value = levelText;
    levelController.text = levelText;
    gradController.text = formatDate(educationsData.graduationDate);
    selectedDate.value = DateTime.parse(educationsData.graduationDate.toString());
  }

  int getLevelValue(String levelText) {
    switch (levelText) {
      case 'Junior High School':
        return 1;
      case 'Senior High School':
        return 2;
      case 'Vocational High School':
        return 3;
      case 'Islamic Boarding High School':
        return 4;
      case 'Diploma III Degree':
        return 5;
      case 'Diploma IV Degree':
        return 6;
      case 'Bachelor\'s Degree':
        return 7;
      case 'Master\'s Degree':
        return 8;
      case 'Doctoral Degree':
        return 9;
      default:
        return 0;
    }
  }

  String getLevelText(int? levelValue) {
    switch (levelValue) {
      case 1:
        return 'Junior High School';
      case 2:
        return 'Senior High School';
      case 3:
        return 'Vocational High School';
      case 4:
        return 'Islamic Boarding High School';
      case 5:
        return 'Diploma III Degree';
      case 6:
        return 'Diploma IV Degree';
      case 7:
        return 'Bachelor\'s Degree';
      case 8:
        return 'Master\'s Degree';
      case 9:
        return 'Doctoral Degree';
      default:
        return '';
    }
  }

  final List<String> levelOptions = [
    'Choose your education level',
    'Junior High School',
    'Senior High School',
    'Vocational High School',
    'Islamic Boarding High School',
    'Diploma III Degree',
    'Diploma IV Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctoral Degree'
  ];
  var selectedLevel = ''.obs;

  Future<void> fetchEducations() async {
    try {
      isLoading.value = true;
      var data = await EducationsService().fetchEducations();
      educationList.assignAll(data);
    } catch(e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void createEducations(EducationsRequest request) async {
    print(request.toJson());
    try {
      isLoading.value = true;
      bool success = await EducationsService().createEducations(request);

      if (success) {
        fetchEducations();
        clearAll();
        customSnackbar(
          'Success Adding Education History!'
        );
      } else {
        customSnackbar(
          'Failed Adding Education History!'
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void updateEducations(EducationsRequest request, int id) async {
    try {
      isLoading.value = true;
      bool success = await EducationsService().updateEducations(request, id);

      if (success) {
        fetchEducations();
        clearAll();
        customSnackbar(
          'Success Update Education History!'
        );
      } else {
        customSnackbar(
          'Failed Update Education History!'
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void deleteEducations(int id) async {
    try {
      isLoading.value = true;
      bool success = await EducationsService().deleteEducations(id);

      if (success) {
        fetchEducations();
        clearAll();
        customSnackbar(
          'Success Deleting Education History!'
        );
      } else {
        customSnackbar(
          'Failed Deleting Education History!',
          secondaryRedColor
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    institutionController.dispose();
    majorController.dispose();
    levelController.dispose();
    gradController.dispose();
    super.onClose();
  }

  void clearAll() {
    institutionController.clear();
    majorController.clear();
    gradController.clear();
    levelController.clear();

    selectedLevel.value = '';
    selectedDate.value = null;
  }

  void setLevel(String? level) {
    if (level != null) {
      selectedLevel.value = level;
      levelController.text = level;
      print(selectedLevel.value);
    }
  }
}
