import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/educations_request.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_dropdown.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../widget/custom_dialog.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/profile_button.dart';
import '../controllers/educations_controller.dart';

class EducationsView extends GetView<EducationsController> {
  const EducationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: neutral02Color,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                  'Add Education History',
                  style: regulerText24
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 13),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Institution Name',
                      style: boldText12,
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                        controller: controller.institutionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter institution name';
                          }
                          return null;
                        },
                        hintText: 'Enter your Institution Name'),
                    const SizedBox(height: 16),
                    Text(
                      'Major/Field of Study',
                      style: boldText12,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: controller.majorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter major/field study name';
                        }
                        return null;
                      },
                      hintText: 'Enter your Major/Field Study',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Level',
                      style: boldText12,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Obx(() => CustomDropdown(
                      hintText: 'Choose your education level',
                      options: controller.levelOptions,
                      selectedOption: controller.selectedLevel.value,
                      onSelected: (String? newLevel) {
                        controller.setLevel(newLevel);
                      },
                    )),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Graduation Date',
                      style: boldText12,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () => controller.selectDate(context),
                      child: AbsorbPointer(
                        child: CustomTextField(
                          controller: controller.gradController,
                          hintText: 'Select your graduation date',
                          suffixIcon: Icon(Icons.calendar_today,
                              color: primaryBlueColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ProfileButton(
                          icon: Icon(
                            Icons.save_outlined,
                            color: neutral01Color,
                          ),
                          color: primaryDarkBlueColor,
                          text: 'Save',
                          onTap: () {
                            if (controller.validateForm()) {
                              if (controller.isEdit.value) {
                                EducationsRequest request = EducationsRequest(
                                    institutionName: controller.institutionController.text,
                                    major: controller.majorController.text,
                                    level: controller.getLevelValue(controller.selectedLevel.value),
                                    graduationDate: controller.formatDateRequest(controller.selectedDate.value ?? DateTime.now())
                                );
                                controller.updateEducations(request, controller.idCard.value);
                                controller.isEdit.value = false;
                                controller.idCard.value = 0;
                              } else {
                                EducationsRequest request = EducationsRequest(
                                    institutionName: controller.institutionController.text,
                                    major: controller.majorController.text,
                                    level: controller.getLevelValue(controller.selectedLevel.value),
                                    graduationDate: controller.formatDateRequest(controller.selectedDate.value ?? DateTime.now())
                                );
                                controller.createEducations(request);
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ProfileButton(
                            icon: Icon(
                              Icons.close,
                              color: neutral01Color,
                            ),
                            color: secondaryRedColor,
                            text: 'Clear',
                            onTap: () {
                              controller.isEdit.value = false;
                              showCustomDialog(
                                content: 'Are you sure you want to clear all data entered?',
                                onConfirm: () {
                                  controller.clearAll();
                                  Get.back();
                                  customSnackbar(
                                    'All data has been deleted successfully'
                                  );
                                },
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            }
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Obx(() => Column(
                      children: controller.educationList.map((activity) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ProfileCard(
                            title: activity.institutionName!,
                            leftSubTitle: activity.major!,
                            startDate: activity.graduationDate != null ? controller.formatDate(activity.graduationDate) : 'N/A',
                            onTap1: () {
                              controller.isEdit.value = true;
                              controller.idCard.value = activity.id!;
                              controller.patchField(activity);
                            },
                            onTap2: () => controller.deleteEducations(activity.id!),
                            onTap3: () {},
                          ),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
