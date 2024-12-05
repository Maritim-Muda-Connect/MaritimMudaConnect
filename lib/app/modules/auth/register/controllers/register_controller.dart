import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/register_request.dart';
import 'package:maritimmuda_connect/app/data/services/auth_service.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/auth/register/views/register_success_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController confirmPassC = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female'];

  var isLoading = false.obs;
  var obscureText = true.obs;
  var confirmObscureText = true.obs;
  var selectedGender = 1.obs;
  var selectedProvince = 0.obs;
  var selectedProvinceReq = 1.obs;
  var isCheckField = false.obs;

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void toggleConfirmObscureText() {
    confirmObscureText.value = !confirmObscureText.value;
  }

  void setSelectedGender(String? value) {
    if (value != null) {
      selectedGender.value = genderOptions.indexOf(value) + 1;
    }
  }

  void setSelectedProvince(String? value) {
    if (value != null) {
      String? selectedKey = provinceOptions.entries
          .firstWhere((entry) => entry.value == value)
          .key;

      selectedProvince.value = provinceOptions.values.toList().indexOf(value);
      selectedProvinceReq.value = int.parse(selectedKey);
    }
  }

  void validateName(String value) {
    formKey.currentState!.validate();
    checkField();
  }

  void validateEmail(String value) {
    formKey.currentState!.validate();
    checkField();
  }

  void validatePassword(String value) {
    formKey.currentState!.validate();
    checkField();
  }

  void validateConfirmPass(String value) {
    formKey.currentState!.validate();
    checkField();
  }

  void checkField() {
    if (nameC.text.isEmpty &&
        emailC.text.isEmpty &&
        passwordC.text.isEmpty &&
        confirmPassC.text.isEmpty) {
      isCheckField.value = false;
    } else {
      isCheckField.value = true;
    }
  }

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  String? validateNameField(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    } else if (value.length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return "Example : yourmail@example.com | Email is required";
    } else if (!isValidEmail(value)) {
      return "Example : yourmail@example.com | Invalid email format";
    }
    return null;
  }

  String? validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return "Password must be 8 or more characters";
    } else if (value.length < 7){
      return "Password must be 8 or more characters";
    }
    return null;
  }

  String? validateConfirmPassField(String? value) {
    if (value == null || value.isEmpty) {
      return "Password does not match";
    }
    return null;
  }

  void register(RegisterRequest request) async {
    try {
      isLoading.value = true;
      bool success = await AuthService().register(request);
      if (success) {
        Get.off(
          () => const RegisterSuccessView(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );
      } else {
        customSnackbar(
          "Register failed, please check your input field",
          secondaryRedColor,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    confirmPassC.dispose();
  }
}
