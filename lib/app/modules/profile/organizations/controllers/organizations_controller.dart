import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/response/organizations_response.dart';
import 'package:maritimmuda_connect/app/data/services/profile/organizations_service.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../../../widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/app/data/models/request/organizations_request.dart';

class OrganizationsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController organizationNameC = TextEditingController();
  final TextEditingController positionC = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final focusNodes = List.generate(6, (_) => FocusNode());

  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  Rx<int?> selectedMonth = Rx<int?>(null);
  Rx<int?> selectedYear = Rx<int?>(null);

  var isLoading = false.obs;
  var isEdit = false.obs;
  var idCard = 0.obs;
  var organizationList = <OrganizationsResponse>[].obs;

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
    fetchOrganizations();
    focusNodes;
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  bool checkField() {
    if (organizationNameC.text.isEmpty &&
        positionC.text.isEmpty &&
        startDateController.text.isEmpty &&
        endDateController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
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

  void patchField(OrganizationsResponse organizationData) {
    organizationNameC.text = organizationData.organizationName ?? '';
    positionC.text = organizationData.role ?? '';
    startDateController.text = formatDate(organizationData.periodStartDate);
    endDateController.text = formatDate(organizationData.periodEndDate);
    selectedStartDate.value =
        DateTime.parse(organizationData.periodStartDate.toString());
    selectedEndDate.value =
        DateTime.parse(organizationData.periodEndDate.toString());
  }

  String? validateOrganization(String? value) {
    if (value == null || value.isEmpty) {
      return "Organization name is required";
    }
    return null;
  }

  String? validatePosition(String? value) {
    if (value == null || value.isEmpty) {
      return "Position is required";
    }
    return null;
  }

  String? validateStartDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Start date is required";
    }
    return null;
  }

  String? validateEndDate(String? value) {
    if (value == null || value.isEmpty) {
      return "End date is required";
    }
    return null;
  }

  Future<void> fetchOrganizations() async {
    try {
      isLoading.value = true;
      var data = await OrganizationsService().fetchOrganizations();
      organizationList.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  void createOrganizations(OrganizationsRequest request) async {
    try {
      isLoading.value = true;
      bool success = await OrganizationsService().createOrganizations(request);

      if (success) {
        fetchOrganizations();
        clearAll();
        customSnackbar(
          'Success adding organization history!',
        );
      } else {
        customSnackbar(
          'Failed adding organization history!',
          secondaryRedColor,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void updateOrganizations(OrganizationsRequest request, int id) async {
    try {
      isLoading.value = true;
      bool success =
          await OrganizationsService().updateOrganizations(request, id);

      if (success) {
        fetchOrganizations();
        clearAll();
        customSnackbar(
          'Success update organization history!',
        );
      } else {
        customSnackbar(
          'Failed update organization history!',
          secondaryRedColor,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void deleteOrganizations(int id) async {
    try {
      isLoading.value = true;
      bool success = await OrganizationsService().deleteOrganizations(id);

      if (success) {
        fetchOrganizations();
        customSnackbar(
          'Success delete organization history!',
          null,
        );
      } else {
        customSnackbar(
          'Failed delete organization history!',
          secondaryRedColor,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void clearAll() {
    organizationNameC.clear();
    positionC.clear();
    startDateController.clear();
    endDateController.clear();
    selectedStartDate.value = null;
    selectedEndDate.value = null;
  }

  @override
  void onClose() {
    super.onClose();
    organizationNameC.dispose();
    positionC.dispose();
    startDateController.dispose();
    endDateController.dispose();
    scrollController.dispose();
  }
}
