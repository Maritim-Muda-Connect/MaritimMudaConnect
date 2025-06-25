import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/login_request.dart';
import 'package:maritimmuda_connect/app/modules/auth/forgot_password/bindings/forgot_password_binding.dart';
import 'package:maritimmuda_connect/app/modules/auth/forgot_password/views/forgot_password_view.dart';
import 'package:maritimmuda_connect/app/modules/auth/register/bindings/register_binding.dart';
import 'package:maritimmuda_connect/app/modules/auth/register/views/register_view.dart';
import 'package:maritimmuda_connect/app/modules/auth/widget/header_auth.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: neutral02Color,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const HeaderAuth(),
                const SizedBox(height: 80),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: neutral03Color, width: 1),
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hi, Welcome!",
                            style: mediumText30.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter your email and password to login",
                            style:
                                regulerText11.copyWith(color: neutral03Color),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
                            style: regulerText12.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.emailC,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            controller.validateEmail(value);
                          },
                          validator: controller.validateEmailField,
                          preffixIcon:
                              Icon(Icons.email_outlined, color: neutral03Color),
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: regulerText12.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => CustomTextField(
                            controller: controller.passwordC,
                            hintText: "Password",
                            keyboardType: TextInputType.text,
                            obscureText: controller.obscureText.value,
                            onChanged: (value) {
                              controller.validatePassword(value);
                            },
                            validator: controller.validatePasswordField,
                            preffixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: neutral03Color,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.toggleObscureText();
                              },
                              icon: Icon(
                                controller.obscureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: neutral03Color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => const ForgotPasswordView(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 100),
                                binding: ForgotPasswordBinding(),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: regulerText12.copyWith(
                                  color: primaryDarkBlueColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        CustomButton(
                          text: "Login",
                          isLoading: controller.isLoading.value,
                          onPressed: () async {
                            if (controller.validateForm()) {
                              controller.login(
                                LoginRequest(
                                  email: controller.emailC.text,
                                  password: controller.passwordC.text,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => const RegisterView(),
                              binding: RegisterBinding(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: regulerText10,
                              ),
                              Text(
                                "Register",
                                style: regulerText10.copyWith(
                                    color: primaryDarkBlueColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
