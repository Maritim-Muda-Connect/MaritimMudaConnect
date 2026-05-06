import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/models/response/general_response.dart';
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
  final ScrollController scrollController = ScrollController();

  final focusNodes = List.generate(7, (_) => FocusNode());
  final List<String> genderOptions = ['Male', 'Female'];
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
  String svgString = '';

  var generalData = GeneralResponse().obs;
  var selectedFirstExpertise = 0.obs;
  var selectedSecondExpertise = 0.obs;
  var selectedGender = 0.obs;
  var province = 1.obs;
  var photoImage = ''.obs;
  var photoIdentity = ''.obs;
  var photoPayment = ''.obs;
  var isLoading = false.obs;
  var photoStudent = ''.obs;
  var qrCodeBase64 = ''.obs;
  var refreshKey = 0.obs;

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

  void setAllController() async {
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
    selectedFirstExpertise.value =
        mapExpertise(generalData.value.user?.firstExpertiseId ?? 0);
    selectedSecondExpertise.value =
        mapExpertise(generalData.value.user?.secondExpertiseId ?? 0);
    photoImage.value = generalData.value.user?.photoLink ?? '';
    photoIdentity.value = generalData.value.user?.identityCardLink ?? '';
    photoPayment.value = generalData.value.user?.paymentLink ?? '';
    photoStudent.value = generalData.value.user?.memberCardPreview ?? '';
    photoPayment.value = generalData.value.user?.paymentLink ?? '';
    qrCodeBase64.value = generalData.value.qrCodeUrl ?? '';
    svgString =
        qrCodeBase64.value.replaceFirst("data:image/svg+xml;base64,", "");
    citizenshipController.text = generalData.value.user?.citizenship ?? '';
  }

  Future<void> fetchGeneral() async {
    try {
      isLoading(true);
      PaintingBinding.instance.imageCache.clear();
      refreshKey.value++;
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
        await fetchGeneral();
        photoImagePath.value = '';
        identityImagePath.value = '';
        paymentImagePath.value = '';
        customSnackbar("Profile updated successfully");
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

  void submitUpdateProfile() {
    var request = GeneralRequest(
      name: nameController.text,
      linkedinProfile: linkedInController.text,
      instagramProfile: instagramController.text,
      gender: selectedGender.value,
      placeOfBirth: placeOfBirthController.text,
      dateOfBirth: dateOfBirthController.text,
      firstExpertiseId: selectedFirstExpertise.value,
      secondExpertiseId: selectedSecondExpertise.value,
      permanentAddress: addressController.text,
      residenceAddress: residenceAddressController.text,
      bio: bioController.text,
    );

    updateGeneral(
      request,
      File(photoImagePath.value),
      File(identityImagePath.value),
      File(paymentImagePath.value),
    );
  }

  void submitKTA() async {
    bool isProfileValid = photoImagePath.value.isNotEmpty || (photoImage.value.isNotEmpty && !photoImage.value.contains("via") && !photoImage.value.contains("cloudinary") && !photoImage.value.contains("default"));
    bool isIdentityValid = identityImagePath.value.isNotEmpty || (photoIdentity.value.isNotEmpty && !photoIdentity.value.contains("via") && !photoIdentity.value.contains("cloudinary"));
    bool isPaymentValid = paymentImagePath.value.isNotEmpty || (photoPayment.value.isNotEmpty && !photoPayment.value.contains("via") && !photoPayment.value.contains("cloudinary"));

    if (isProfileValid && isIdentityValid && isPaymentValid) {
      try {
        isLoading(true);
        bool success = await GeneralService().notifyMemberCard();
        if (success) {
          customSnackbar("Email Terkirim!");
        } else {
          customSnackbar(
            "Failed to send email",
            secondaryRedColor,
          );
        }
      } catch (e) {
        customSnackbar(
          "An error occurred: $e",
          secondaryRedColor,
        );
      } finally {
        isLoading(false);
      }
    } else {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFF3B47D), width: 3),
                  ),
                  child: const Text(
                    "!",
                    style: TextStyle(
                      fontSize: 48,
                      color: Color(0xFFF3B47D),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "To create a membership card, you must upload a Profile Photo,National Identity Card and Student Card/Business Card.",
                  textAlign: TextAlign.center,
                  style: regulerText14.copyWith(color: neutral04Color, fontSize: 16),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A728A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => Get.back(),
                    child: Text(
                      "Close",
                      style: regulerText14.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
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
    citizenshipController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
