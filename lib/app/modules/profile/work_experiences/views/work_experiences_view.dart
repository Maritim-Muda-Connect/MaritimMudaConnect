import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/work_experiences_request.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_dialog.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/profile_button.dart';
import '../controllers/work_experiences_controller.dart';

class WorkExperiencesView extends GetView<WorkExperiencesController> {
  const WorkExperiencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                  'Add Work Experience',
                  style: regulerText24
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 13),
              child: Form(
                key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Position Title', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.positionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter position title';
                          }
                          return null;
                        },
                        hintText: 'Enter your position title',
                      ),
                      const SizedBox(height: 16),
                      Text('Institution Name', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.institutionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter institution name';
                          }
                          return null;
                        },
                        hintText: 'Enter your institution name',
                      ),
                      const SizedBox(height: 16),
                      Text('Start Date', style: boldText12),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => controller.selectStartDate(context),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: controller.startDateController,
                            hintText: 'Select start date',
                            suffixIcon: Icon(Icons.calendar_today, color: primaryBlueColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('End Date', style: boldText12),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => controller.selectEndDate(context),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: controller.endDateController,
                            hintText: 'Select end date',
                            suffixIcon: Icon(Icons.calendar_today, color: primaryBlueColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileButton(
                            icon: Icon(Icons.save_outlined, color: neutral01Color),
                            color: primaryDarkBlueColor,
                            text: 'Save',
                            onTap: () {
                              if (controller.validateForm()) {
                                if (controller.isEdit.value) {
                                  WorkExperiencesRequest request = WorkExperiencesRequest(
                                    positionTitle: controller.positionController.text,
                                    companyName: controller.institutionController.text,
                                    startDate: controller.formatDateRequest(controller.selectedStartDate.value ?? DateTime.now()),
                                    endDate: controller.formatDateRequest(controller.selectedEndDate.value ?? DateTime.now())
                                  );
                                  controller.updateWorkExperience(request, controller.idCard.value);
                                  controller.isEdit.value = false;
                                  controller.idCard.value = 0;
                                } else {
                                  WorkExperiencesRequest request = WorkExperiencesRequest(
                                    positionTitle: controller.positionController.text,
                                    companyName: controller.institutionController.text,
                                    startDate: controller.formatDateRequest(controller.selectedStartDate.value ?? DateTime.now()),
                                    endDate: controller.formatDateRequest(controller.selectedEndDate.value ?? DateTime.now())
                                  );
                                  controller.createWorkExperience(request);
                                }
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          ProfileButton(
                              icon: Icon(Icons.close, color: neutral01Color),
                              color: secondaryRedColor,
                              text: 'Clear',
                              onTap: () {
                                showCustomDialog(
                                    content: 'Are you sure you want to clear all data entered?',
                                    onConfirm: () {
                                      controller.clearAll();
                                      Get.back();
                                      customSnackbar(
                                        'All data has been deleted successfully',
                                      );
                                    },
                                    onCancel: () {
                                      Get.back();
                                    }
                                );
                              }
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Obx(() => Column(
                        children: controller.workExperienceLists.map((activity) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ProfileCard(
                              title: activity.positionTitle!,
                              leftSubTitle: activity.companyName!,
                              startDate: activity.startDate != null ? controller.formatDate(activity.startDate) : 'N/A',
                              endDate: activity.endDate != null ? controller.formatDate(activity.endDate) : 'N/A',
                              onTap1: () {
                                controller.isEdit.value = true;
                                controller.idCard.value = activity.id!;
                                controller.patchField(activity);
                              },
                              onTap2: () => controller.deleteWorkExperience(activity.id!),
                              onTap3: () {},
                            ),
                          );
                        }).toList(),
                      )),
                    ],
                  )
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
