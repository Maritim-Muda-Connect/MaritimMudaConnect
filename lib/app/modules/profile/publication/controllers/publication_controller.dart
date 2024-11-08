import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/request/publication_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/publication_response.dart';
import 'package:maritimmuda_connect/app/data/services/publication_service.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../../../widget/custom_snackbar.dart';

class PublicationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleC = TextEditingController();
  final TextEditingController authorC = TextEditingController();
  final TextEditingController pubTypeC = TextEditingController();
  final TextEditingController publisherC = TextEditingController();
  final TextEditingController cityC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final ScrollController scrollController = ScrollController();


  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Updated file related variables
  RxString selectedFileName = 'No File Chosen'.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString selectedImagePath = ''.obs;

  var publicationData = <PublicationResponse>[].obs;
  var isLoading = false.obs;
  var isEdit = false.obs;
  var idCard = 0.obs;
  var selectedPublicationType = 1.obs;

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM').format(date);
  }

  Rx<int?> selectedMonth = Rx<int?>(null);
  Rx<int?> selectedYear = Rx<int?>(null);

  String get formattedMonthYear {
    if (selectedMonth.value != null && selectedYear.value != null) {
      return DateFormat('MMMM yyyy')
          .format(DateTime(selectedYear.value!, selectedMonth.value!));
    } else {
      return '';
    }
  }

  @override
  void onInit(){
    super.onInit();
    fetchPublications();
    selectedPublicationType.value = 1;
  }

  bool checkField() {
    if (titleC.text.isEmpty &&
        authorC.text.isEmpty &&
        pubTypeC.text.isEmpty &&
        publisherC.text.isEmpty &&
        cityC.text.isEmpty &&
        dateC.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return "Title is required";
    }
    return null;
  }

  String? validateAuthors(String? value) {
    if (value == null || value.isEmpty) {
      return "Author(s) is required";
    }
    return null;
  }

  String? validatePublicationType(String? value) {
    if (value == null || value.isEmpty) {
      return "Publication Type is required";
    }
    return null;
  }

  String? validatePublisher(String? value) {
    if (value == null || value.isEmpty) {
      return "Publisher is required";
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return "City of Publisher is required";
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Date of Publication is required";
    }
    return null;
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
        dateC.text = formattedMonthYear;
      },
    );
  }

  final List<String> publicationOptions = [
    'Choose your publications type',
    'Abstract',
    'Book',
    'Journal Article',
    'Magazine Article',
    'News Article',
    'Proceeding Article',
  ];

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      selectedFileName.value = result.files.single.name;
      selectedImagePath.value = result.files.single.path!;
      selectedImage.value = File(result.files.single.path!);
    } else {
      selectedFileName.value = 'No File Chosen';
      selectedImagePath.value = '';
      selectedImage.value = null;
    }
  }

  void patchField(PublicationResponse publicationData) {
    titleC.text = publicationData.title ?? '';
    authorC.text = publicationData.authorName ?? '';
    selectedPublicationType.value = publicationData.type ?? 0;
    publisherC.text = publicationData.publisher ?? '';
    cityC.text = publicationData.city ?? '';
    dateC.text = formatDate(publicationData.publishDate ?? DateTime.now());
  }

  Future<void> fetchPublications() async {
    try {
      isLoading.value = true;
      var data = await PublicationService().fetchPublication();
      publicationData.assignAll(data);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void createPublication(PublicationRequest request) async {
    print(request.toJson());
    try {
      isLoading.value = true;
      bool success = await PublicationService().createPublication(request);
      if (success) {
        fetchPublications();
        clearAll();
        customSnackbar(
          'Success adding publication history!',
        );
      } else {
        customSnackbar(
          'Failed adding publication history!',
          secondaryRedColor,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void updatePublications(PublicationRequest request, int id) async {
    try {
      isLoading.value = true;
      bool success = await PublicationService().updatePublications(request, id);

      if (success) {
        await fetchPublications();
        clearAll();
        customSnackbar(
          'Success update publication history!',
        );
      } else {
        customSnackbar(
          'Failed update publication history!',
          secondaryRedColor,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void deletePublication(int id) async {
    try {
      isLoading.value = true;
      bool success = await PublicationService().deletePublication(id);

      if (success) {
        fetchPublications();
        customSnackbar(
          'Success delete publication!',
          null,
          const Duration(milliseconds: 800),
        );
      } else {
        customSnackbar(
          'Failed delete publication!',
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
    titleC.clear();
    authorC.clear();
    pubTypeC.clear();
    publisherC.clear();
    cityC.clear();
    dateC.clear();

    selectedFileName.value = 'No File Chosen';
    selectedImagePath.value = '';
    selectedImage.value = null;
  }

  @override
  void onClose() {
    titleC.dispose();
    authorC.dispose();
    pubTypeC.dispose();
    publisherC.dispose();
    dateC.dispose();
    cityC.dispose();
    scrollController.dispose();
    super.onClose();
  }
  void setPublicationType(String? value) {
    if (value != null) {
      selectedPublicationType.value = publicationOptions.indexOf(value) + 1;
    }
  }
}