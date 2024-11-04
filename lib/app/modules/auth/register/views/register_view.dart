import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/register_request.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/auth/widget/header_auth.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_dropdown.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
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
                const SizedBox(height: 55),
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
                            "Register",
                            style: mediumText30.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter a few details below",
                            style:
                                regulerText11.copyWith(color: neutral03Color),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Name",
                            style: regulerText12.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: controller.nameC,
                          hintText: "Name",
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            controller.validateName(value);
                          },
                          validator: controller.validateNameField,
                          preffixIcon: Icon(Icons.person_outline_sharp,
                              color: neutral03Color),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Gender",
                            style: regulerText12.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => CustomDropdown(
                            options: controller.genderOptions,
                            selectedOption: controller.genderOptions[
                                controller.selectedGender.value - 1],
                            onSelected: (String? value) {
                              controller.setSelectedGender(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Province",
                            style: regulerText12.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => CustomDropdown(
                            options: provinceOptions.values.toList(),
                            selectedOption: provinceOptions.values
                                .toList()[controller.selectedProvince.value],
                            onSelected: (String? value) {
                              controller.setSelectedProvince(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Confirm Password",
                            style: regulerText12.copyWith(
                                color: primaryDarkBlueColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => CustomTextField(
                            controller: controller.confirmPassC,
                            hintText: "Confirm Password",
                            keyboardType: TextInputType.text,
                            obscureText: controller.obscureText.value,
                            onChanged: (value) {
                              controller.validateConfirmPass(value);
                            },
                            validator: controller.validateConfirmPassField,
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
                        const SizedBox(height: 30),
                        Obx(
                          () {
                            if (controller.isCheckField.value) {
                              return CustomButton(
                                text: "Register",
                                isLoading: controller.isLoading.value,
                                onPressed: () {
                                  if (controller.validateForm()) {
                                    controller.register(
                                      RegisterRequest(
                                        name: controller.nameC.text,
                                        email: controller.emailC.text,
                                        gender: controller.selectedGender.value,
                                        provinceId: controller
                                            .selectedProvinceReq.value,
                                        password: controller.passwordC.text,
                                        passwordConfirmation:
                                            controller.confirmPassC.text,
                                      ),
                                    );
                                  }
                                },
                              );
                            } else {
                              return CustomButton(
                                onPressed: () {},
                                text: "Register",
                                color: neutral03Color,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: regulerText10,
                              ),
                              Text(
                                "Login",
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
