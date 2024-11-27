import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/general_response.dart';
import 'package:maritimmuda_connect/app/data/services/general_service.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final provincialOrgController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final linkedInController = TextEditingController();
  final instagramController = TextEditingController();
  final addressController = TextEditingController();
  final residenceAddressController = TextEditingController();
  final bioController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final focusNodes = List.generate(7, (_) => FocusNode());
  final List<String> genderOptions = ["Choose your gender", 'Male', 'Female'];
  final RxString photoImagePath = ''.obs;
  final RxString photoImageName = ''.obs;
  final RxString identityImagePath = ''.obs;
  final RxString identityImageName = ''.obs;
  final RxString studentImagePath = ''.obs;
  final RxString studentImageName = ''.obs;
  final RxString paymentImagePath = ''.obs;
  final RxString paymentImageName = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<int?> selectedMonth = Rx<int?>(null);
  Rx<int?> selectedYear = Rx<int?>(null);

  var generalData = GeneralResponse().obs;
  var selectedFirstExpertise = 0.obs;
  var selectedSecondExpertise = 0.obs;
  var selectedGender = 1.obs;
  var province = 1.obs;
  var photoImage = ''.obs;
  var photoIdentity = ''.obs;
  var photoPayment = ''.obs;
  var isLoading = false.obs;

  String get formattedDate {
    return selectedDate.value != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
        : '';
  }

  int mapExpertise(int value) {
    if (value >= 2 && value <= 25) {
      return value;
    } else if (value >= 27 && value <= 50) {
      return value - 25;
    } else if (value >= 52 && value <= 75) {
      return value - 50;
    }
    return 0;
  }

  @override
  void onInit() {
    focusNodes;
    super.onInit();
    fetchGeneral();
  }

  void setGender(String? value) {
    if (value != null) {
      selectedGender.value = genderOptions.indexOf(value);
    }
  }

  void setFirstExpertise(String? value) {
    if (value != null) {
      selectedFirstExpertise.value = firstExpertise.indexOf(value);
    }
  }

  void setSecondExpertise(String? value) {
    if (value != null) {
      selectedSecondExpertise.value = secondExpertise.indexOf(value);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dateOfBirthController.text = formattedDate;
    }
  }

  void setAllController() {
    String provinceId = generalData.value.user?.provinceId?.toString() ?? '1';
    String provinceName = provinceOptions[provinceId] ?? '';

    nameController.text = generalData.value.user?.name ?? '';
    emailController.text = generalData.value.user?.email ?? '';
    provincialOrgController.text = provinceName;
    placeOfBirthController.text = generalData.value.user?.placeOfBirth ?? '';
    dateOfBirthController.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(generalData.value.user!.dateOfBirth.toString()));
    linkedInController.text = generalData.value.user?.linkedinProfile ?? '';
    instagramController.text = generalData.value.user?.instagramProfile ?? '';
    addressController.text = generalData.value.user?.permanentAddress ?? '';
    residenceAddressController.text =
        generalData.value.user?.residenceAddress ?? '';
    bioController.text = generalData.value.user?.bio ?? '';
    selectedFirstExpertise.value =
        mapExpertise(generalData.value.user?.firstExpertiseId ?? 0);
    selectedSecondExpertise.value =
        mapExpertise(generalData.value.user?.secondExpertiseId ?? 0);
    photoImage.value = generalData.value.user?.photoLink ?? '';
    photoIdentity.value = generalData.value.user?.identityCardLink ?? '';
    photoPayment.value = generalData.value.user?.paymentLink ?? '';
  }

  Future<void> fetchGeneral() async {
    try {
      isLoading(true);
      var data = await GeneralService().fetchGeneral();
      generalData.value = data;

      setAllController();
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void updateGeneral(
    GeneralRequest request,
    File imagePhoto,
    File imageIdentity,
  ) async {
    try {
      isLoading(true);
      bool success = await GeneralService().updateGeneral(
        request,
        imagePhoto,
        imageIdentity,
      );

      if (success) {
        await Future.delayed(const Duration(seconds: 2));
        photoImagePath.value = '';
        identityImagePath.value = '';
        customSnackbar("Profile updated successfully");
        fetchGeneral();
      } else {
        customSnackbar(
          "Profile update failed, please check your input field",
          secondaryRedColor,
        );
      }
    } catch (e) {
      print("Error controller profil $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    provincialOrgController.dispose();
    placeOfBirthController.dispose();
    dateOfBirthController.dispose();
    linkedInController.dispose();
    instagramController.dispose();
    addressController.dispose();
    residenceAddressController.dispose();
    bioController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
