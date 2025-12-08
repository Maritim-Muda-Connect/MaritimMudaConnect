import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/login_request.dart';
import 'package:maritimmuda_connect/app/data/services/auth/auth_service.dart';
import 'package:maritimmuda_connect/app/modules/navbar/bindings/main_binding.dart';
import 'package:maritimmuda_connect/app/modules/navbar/views/main_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  var isLoading = false.obs;
  var obscureText = true.obs;
  var isCheckField = false.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  void validateEmail(String value) {
    formKey.currentState!.validate();
    checkField();
  }

  void validatePassword(String value) {
    formKey.currentState!.validate();
    checkField();
  }

  void checkField() {
    if (validateEmailField(emailC.text) == null &&
        validatePasswordField(passwordC.text) == null) {
      isCheckField.value = true;
    } else {
      isCheckField.value = false;
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

  String? validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  void login(LoginRequest request) async {
    try {
      isLoading.value = true;
      int statusCode = await AuthService().login(request);

      if (statusCode == 200) {
        Get.offAll(
          () => MainView(),
          binding: MainBinding(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 100),
        );
      } else if (statusCode == 400) {
        customSnackbar(
          "Login failed, your account is not verified please check your email.",
          secondaryRedColor,
        );
      } else if (statusCode == 401) {
        customSnackbar(
          "Login failed, invalid email or password.",
          secondaryRedColor,
        );
      } else if (statusCode == 404) {
        customSnackbar(
          "Login failed, account not found.",
          secondaryRedColor,
        );
      } else if (statusCode == 500) {
        customSnackbar(
          "Server error, please try again later.",
          secondaryRedColor,
        );
      } else if (statusCode == 503) {
        customSnackbar(
          "Service unavailable, server is under maintenance. Please try again later.",
          secondaryRedColor,
        );
      } else {
        customSnackbar(
          "Login failed, please check your email and password.",
          secondaryRedColor,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();

      if (errorMessage.contains("SocketException") ||
          errorMessage.contains("Failed host lookup")) {
        customSnackbar(
          "No internet connection or server is unreachable.",
          secondaryRedColor,
        );
      } else {
        customSnackbar(
          "An unexpected error occurred.",
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
    passwordC.dispose();
  }
}
