import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/request/delete_account_request.dart';
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/general_response.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/routes/app_pages.dart';
import 'package:maritimmuda_connect/app/data/services/profile/general_service.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/controllers/e_kta_controller.dart';
import 'package:maritimmuda_connect/app/modules/home/controllers/home_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/profile_user/controllers/profile_user_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final profileUserController = Get.find<ProfileUserController>();
  final homeController = Get.find<HomeController>();
  final ektaController = Get.put(EKtaController());

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
  final citizenshipController = TextEditingController();
  final deleteReasonController = TextEditingController();
  final deletePasswordController = TextEditingController();
  final deleteConfirmInputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final focusNodes = List.generate(7, (_) => FocusNode());
  final genderOptions = ['Male', 'Female'];

  final photoImagePath = ''.obs;
  final photoImageName = ''.obs;
  final identityImagePath = ''.obs;
  final identityImageName = ''.obs;
  final studentImagePath = ''.obs;
  final studentImageName = ''.obs;
  final paymentImagePath = ''.obs;
  final paymentImageName = ''.obs;

  final RxBool isDeleteConfirmValid = false.obs;
  final RxBool isDeletePasswordFilled = false.obs;
  final RxBool isDeletePasswordHidden = true.obs;

  final nameError = ''.obs;
  final genderError = ''.obs;
  final firstExpertiseError = ''.obs;
  final secondExpertiseError = ''.obs;
  final photoError = ''.obs;
  final identityCardError = ''.obs;
  final studentCardError = ''.obs;

  final selectedDate = Rx<DateTime?>(null);
  final selectedMonth = Rx<int?>(null);
  final selectedYear = Rx<int?>(null);
  String svgString = '';

  final generalData = GeneralResponse().obs;
  final selectedFirstExpertise = 0.obs;
  final selectedSecondExpertise = 0.obs;
  final selectedGender = 0.obs;
  final selectedCitizenship = ''.obs;
  final photoImage = ''.obs;
  final photoIdentity = ''.obs;
  final photoPayment = ''.obs;
  final isLoading = false.obs;
  final photoStudent = ''.obs;
  final qrCodeBase64 = ''.obs;

  String get formattedDate {
    return selectedDate.value != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
        : '';
  }

  int mapExpertise(int value) {
    if (value == 54) {
      return 0;
    }
    if (value >= 1 && value <= 25) {
      return value;
    } else if (value >= 27 && value <= 50) {
      return value - 26;
    } else if (value >= 52 && value <= 53) {
      return value - 51;
    } else if (value >= 55 && value <= 75) {
      return value - 54;
    }
    return 0;
  }

  int getFirstExpertiseId(int index) {
    if (index == 0) return 1;
    if (index >= 1 && index <= 25) {
      return index;
    }
    return 1;
  }

  int getSecondExpertiseId(int index) {
    if (index == 0) return 54;
    if (index >= 1 && index <= 24) {
      return index + 26;
    }
    if (index == 25) {
      return 52;
    }
    if (index >= 26) {
      return index + 29;
    }
    return 54;
  }

  @override
  void onInit() {
    focusNodes;
    super.onInit();
    resetAllErrors();
    fetchGeneral();
  }

  bool validateForm() {
    bool isValid = true;

    nameError.value = '';
    genderError.value = '';
    firstExpertiseError.value = '';
    secondExpertiseError.value = '';
    identityCardError.value = '';
    studentCardError.value = '';

    if (nameController.text.trim().isEmpty) {
      nameError.value = 'Name cannot be empty';
      isValid = false;
    }

    if (selectedGender.value >= 0 &&
        selectedGender.value < genderOptions.length) {}

    if (selectedGender.value < 0) {
      genderError.value = 'Please select your gender';
      isValid = false;
    }

    if (selectedFirstExpertise.value == 0) {
      firstExpertiseError.value = 'Please select your first expertise';
      isValid = false;
    }

    if (selectedFirstExpertise.value > 0 &&
        selectedSecondExpertise.value > 0 &&
        selectedFirstExpertise.value == selectedSecondExpertise.value) {
      secondExpertiseError.value =
          'Second expertise must be different from first expertise';
      isValid = false;
    }

    // bool hasIdentityCard = identityImagePath.value.isNotEmpty ||
    //     (photoIdentity.value.isNotEmpty &&
    //         !photoIdentity.value.contains("via") &&
    //         !photoIdentity.value.contains("cloudinary") &&
    //         !photoIdentity.value.contains("placeholder"));

    // if (!hasIdentityCard) {
    //   identityCardError.value = 'Please upload your identity card';
    //   isValid = false;
    // }

    // bool hasStudentCard = paymentImagePath.value.isNotEmpty ||
    //     (photoPayment.value.isNotEmpty &&
    //         !photoPayment.value.contains("via") &&
    //         !photoPayment.value.contains("cloudinary") &&
    //         !photoPayment.value.contains("placeholder"));

    // if (!hasStudentCard) {
    //   studentCardError.value = 'Please upload your student or business card';
    //   isValid = false;
    // }

    if (!isValid) {
      customSnackbar(
        'Please complete all required fields',
        secondaryRedColor,
      );
    }

    return isValid;
  }

  void setGender(String? value) {
    if (value != null) {
      selectedGender.value = genderOptions.indexOf(value);
      if (selectedFirstExpertise.value > 0 &&
          selectedFirstExpertise.value == selectedSecondExpertise.value) {
        secondExpertiseError.value =
            'Second expertise must be different from first expertise';
      } else {
        secondExpertiseError.value = '';
      }
    }
  }

  void setFirstExpertise(String? value) {
    if (value != null) {
      selectedFirstExpertise.value = firstExpertise.indexOf(value);
      if (selectedSecondExpertise.value > 0 &&
          selectedFirstExpertise.value == selectedSecondExpertise.value) {
        secondExpertiseError.value =
            'Second expertise must be different from first expertise';
      } else {
        secondExpertiseError.value = '';
      }
    }
  }

  void setSecondExpertise(String? value) {
    if (value != null) {
      selectedSecondExpertise.value = secondExpertise.indexOf(value);
    }
  }

  void setCitizenship(String? value) {
    if (value != null) {
      selectedCitizenship.value = value;
      citizenshipController.text = value;
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

  void validateDeleteConfirm(String value) {
    isDeleteConfirmValid.value = value == "DELETE";
  }

  void clearDeleteConfirm() {
    deleteConfirmInputController.clear();
    isDeleteConfirmValid.value = false;
  }

  void validateDeletePassword(String value) {
    isDeletePasswordFilled.value = value.isNotEmpty;
  }

  void toggleDeletePasswordVisibility() {
    isDeletePasswordHidden.value = !isDeletePasswordHidden.value;
  }

  void requestDeleteAccount({required VoidCallback onSuccess}) async {
    if (deletePasswordController.text.isEmpty) {
      customSnackbar("Please fill the password", secondaryRedColor);
      return;
    }

    try {
      isLoading(true);
      final request = DeleteAccountRequest(
        password: deletePasswordController.text,
        confirmDelete: "",
        reason: deleteReasonController.text,
      );

      final response = await GeneralService().deleteAccountRequest(request);

      if (!response.success &&
          (response.message.toLowerCase().contains("password tidak valid"))) {
        customSnackbar(response.message, secondaryRedColor);
      } else {
        onSuccess();
      }
    } catch (e) {
      customSnackbar("An error occurred", secondaryRedColor);
    } finally {
      isLoading(false);
    }
  }

  void confirmDeleteAccount() async {
    try {
      isLoading(true);
      final request = DeleteAccountRequest(
        password: deletePasswordController.text,
        confirmDelete: "DELETE",
        reason: deleteReasonController.text,
      );

      final response = await GeneralService().deleteAccountRequest(request);

      if (response.success) {
        Get.dialog(
          AlertDialog(
            backgroundColor: neutral01Color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Request Received",
                style: boldText16, textAlign: TextAlign.center),
            content: Text(
              "Your account deletion request has been received and will be processed within a maximum of 5 working days. Thank you for being a part of Maritim Muda Connect.",
              style: regulerText12,
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await UserPreferences().logout();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Text("Understood",
                      style: semiBoldText12.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      } else {
        customSnackbar(response.message, secondaryRedColor);
      }
    } catch (e) {
      customSnackbar("An error occurred", secondaryRedColor);
    } finally {
      isLoading(false);
      deleteReasonController.clear();
      deletePasswordController.clear();
      deleteConfirmInputController.clear();
      isDeleteConfirmValid.value = false;
      isDeletePasswordFilled.value = false;
    }
  }

  void setAllController() async {
    resetAllErrors();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String provinceId = generalData.value.user?.provinceId?.toString() ?? '1';
    String provinceName = provinceOptions[provinceId] ?? '';
    String? uid = generalData.value.user?.uid ?? "";
    await prefs.setString("uid", uid);

    nameController.text = generalData.value.user?.name ?? '';
    emailController.text = generalData.value.user?.email ?? '';
    provincialOrgController.text = provinceName;
    placeOfBirthController.text = generalData.value.user?.placeOfBirth ?? '';
    dateOfBirthController.text = generalData.value.user?.dateOfBirth != null
        ? DateFormat('yyyy-MM-dd').format(generalData.value.user!.dateOfBirth!)
        : '';
    linkedInController.text = generalData.value.user?.linkedinProfile ?? '';
    instagramController.text = generalData.value.user?.instagramProfile ?? '';
    addressController.text = generalData.value.user?.permanentAddress ?? '';
    residenceAddressController.text =
        generalData.value.user?.residenceAddress ?? '';
    bioController.text = generalData.value.user?.bio ?? '';

    int genderFromApi = generalData.value.user?.gender ?? -1;
    if (genderFromApi == 0) {
      selectedGender.value = 0;
    } else if (genderFromApi == 1) {
      selectedGender.value = 1;
    } else {
      selectedGender.value = -1;
    }

    int firstExpertiseIdApi = generalData.value.user?.firstExpertiseId ?? 0;
    int secondExpertiseIdApi = generalData.value.user?.secondExpertiseId ?? 0;

    selectedFirstExpertise.value = mapExpertise(firstExpertiseIdApi);
    selectedSecondExpertise.value = mapExpertise(secondExpertiseIdApi);

    photoImage.value = generalData.value.user?.photoLink ?? '';
    photoIdentity.value = generalData.value.user?.identityCardLink ?? '';
    photoPayment.value = generalData.value.user?.paymentLink ?? '';
    photoStudent.value = generalData.value.user?.memberCardPreview ?? '';

    citizenshipController.text = generalData.value.user?.citizenship ?? '';
    selectedCitizenship.value = generalData.value.user?.citizenship ?? '';

    qrCodeBase64.value = generalData.value.qrCodeUrl ?? '';
    svgString =
        qrCodeBase64.value.replaceFirst("data:image/svg+xml;base64,", "");
  }

  Future<void> fetchGeneral() async {
    try {
      isLoading(true);
      resetAllErrors();
      var data = await GeneralService().fetchGeneral();
      generalData.value = data;

      setAllController();
    } finally {
      isLoading(false);
    }
  }

  void updateGeneral(
    GeneralRequest request,
    File imagePhoto,
    File imageIdentity,
    File imagePayment,
  ) async {
    try {
      isLoading(true);
      bool success = await GeneralService().updateGeneral(
        request,
        imagePhoto,
        imageIdentity,
        imagePayment,
      );

      if (success) {
        await Future.delayed(const Duration(seconds: 2));
        photoImagePath.value = '';
        identityImagePath.value = '';
        paymentImagePath.value = '';
        customSnackbar("Profile updated successfully");
        fetchGeneral();
        Get.put(HomeController());
        Get.put(ProfileUserController());
        Get.put(EKtaController());
        profileUserController.fetchGeneral();
        homeController.fetchGeneral();
        ektaController.getEkta();
      } else {
        customSnackbar(
          "Profile update failed, please check your input field",
          secondaryRedColor,
        );
      }
    } finally {
      isLoading(false);
    }
  }

  void resetAllErrors() {
    nameError.value = '';
    genderError.value = '';
    firstExpertiseError.value = '';
    secondExpertiseError.value = '';
    identityCardError.value = '';
    studentCardError.value = '';
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
    citizenshipController.dispose();
    deleteReasonController.dispose();
    deletePasswordController.dispose();
    deleteConfirmInputController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
