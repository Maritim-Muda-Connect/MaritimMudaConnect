import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/request/researches_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/researches_response.dart';
import 'package:maritimmuda_connect/app/data/services/researches_service.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../widget/custom_snackbar.dart';

class ResearchesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController researchTitleC = TextEditingController();
  final TextEditingController roleC = TextEditingController();
  final TextEditingController affiliationC = TextEditingController();
  final TextEditingController sponsorC = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  Rx<int?> selectedMonth = Rx<int?>(null);
  Rx<int?> selectedYear = Rx<int?>(null);

  var isLoading = false.obs;
  var isEdit = false.obs;
  var idCard = 0.obs;
  var researcheLists = <ResearchesResponse>[].obs;

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
    fetchResearches();
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

  void patchField(ResearchesResponse researcheData) {
    researchTitleC.text = researcheData.name ?? '';
    roleC.text = researcheData.role ?? '';
    affiliationC.text = researcheData.institutionName ?? '';
    sponsorC.text = researcheData.sponsorName ?? '';
    startDateController.text = formatDate(researcheData.startDate);
    endDateController.text = formatDate(researcheData.endDate);
    selectedStartDate.value =
        DateTime.parse(researcheData.startDate.toString());
    selectedEndDate.value = DateTime.parse(researcheData.endDate.toString());
  }

  Future<void> fetchResearches() async {
    try {
      isLoading.value = true;
      var data = await ResearchesService().fetchResearches();
      researcheLists.assignAll(data);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void createResearche(ResearchesRequest request) async {
    print(request.toJson());
    try {
      isLoading.value = true;
      bool success = await ResearchesService().createResearche(request);

      if (success) {
        await fetchResearches();
        clearAll();
        customSnackbar(
          'Success adding research history!',
        );
      } else {
        customSnackbar(
          'Failed adding research history!',
          secondaryRedColor,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void updateResearche(ResearchesRequest request, int id) async {
    try {
      isLoading.value = true;
      bool success = await ResearchesService().updateResearche(request, id);

      if (success) {
        await fetchResearches();
        clearAll();
        customSnackbar(
          'Success update research history!',
        );
      } else {
        customSnackbar(
          'Failed update research history!',
          secondaryRedColor,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void deleteResearche(int id) async {
    try {
      isLoading.value = true;
      bool success = await ResearchesService().deleteResearche(id);

      if (success) {
        await fetchResearches();
        customSnackbar(
          'Success delete research!',
          null,
          const Duration(milliseconds: 800),
        );
      } else {
        customSnackbar(
          'Failed delete research!',
          secondaryRedColor,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void clearAll() {
    researchTitleC.clear();
    roleC.clear();
    affiliationC.clear();
    sponsorC.clear();
    startDateController.clear();
    endDateController.clear();
    selectedStartDate.value = null;
    selectedEndDate.value = null;
  }

  @override
  void onClose() {
    super.onClose();
    researchTitleC.dispose();
    roleC.dispose();
    sponsorC.dispose();
    startDateController.dispose();
    endDateController.dispose();
  }
}
