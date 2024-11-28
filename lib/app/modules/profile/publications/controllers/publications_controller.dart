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

class PublicationsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleC = TextEditingController();
  final TextEditingController authorC = TextEditingController();
  final TextEditingController pubTypeC = TextEditingController();
  final TextEditingController publisherC = TextEditingController();
  final TextEditingController cityC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final focusNodes = List.generate(6, (_) => FocusNode());

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  RxString selectedFileName = 'No File Chosen'.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString selectedImagePath = ''.obs;

  var publicationData = <PublicationResponse>[].obs;
  var isLoading = false.obs;
  var isEdit = false.obs;
  var idCard = 0.obs;
  var selectedPublicationType = ''.obs;

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('MMMM yyyy').format(date) : '';
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
  void onInit() {
    super.onInit();
    fetchPublications();
    focusNodes;
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

  int getTypeValue(String levelText) {
    switch (levelText) {
      case 'Abstract':
        return 1;
      case 'Book':
        return 2;
      case 'Journal Article':
        return 3;
      case 'Magazine Article':
        return 4;
      case 'News Article':
        return 5;
      case 'Proceeding Article':
        return 6;
      default:
        return 0;
    }
  }

  String getTypeText(int? levelValue) {
    switch (levelValue) {
      case 1:
        return 'Abstract';
      case 2:
        return 'Book';
      case 3:
        return 'Journal Article';
      case 4:
        return 'Magazine Article';
      case 5:
        return 'News Article';
      case 6:
        return 'Proceeding Article';
      default:
        return '';
    }
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
    String typeText = getTypeText(publicationData.type);
    selectedPublicationType.value = typeText;
    pubTypeC.text = typeText;
    publisherC.text = publicationData.publisher ?? '';
    cityC.text = publicationData.city ?? '';
    dateC.text = formatDate(publicationData.publishDate ?? DateTime.now());
  }

  Future<void> fetchPublications() async {
    try {
      isLoading.value = true;
      var data = await PublicationService().fetchPublication();
      selectedPublicationType("");
      publicationData.assignAll(data);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void createPublication(PublicationRequest request) async {
    try {
      print(request.type);
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
          'Success deleting publication history!',
          null,
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

  void setPubType(String? level) {
    if (level != null) {
      selectedPublicationType.value = level;
      pubTypeC.text = level;
      print(selectedPublicationType.value);
    }
  }
}
