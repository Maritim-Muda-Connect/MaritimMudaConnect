import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/services/auth/auth_service.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();

  var isCheckField = false.obs;
  var isSuccesSend = false.obs;
  var isLoading = false.obs;

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void validateEmail(String value) {
    formKey.currentState!.validate();
    checkField();
  }

  void checkField() {
    if (emailC.text.isEmpty) {
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

  String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!isValidEmail(value)) {
      return "Enter a valid email format";
    }
    return null;
  }

  void forgotPassword(String email) async {
    try {
      isLoading.value = true;
      bool success = await AuthService().forgotPassword(email);
      if (success) {
        isSuccesSend.value = true;
      } else {
        customSnackbar(
          "Reset password failed, please check your email",
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
    emailC.dispose();
  }
}
