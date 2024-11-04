import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/social_activity/controllers/social_activity_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../../../../data/models/request/social_activity_request.dart';
import '../../../widget/custom_dialog.dart';

class SocialActivityView extends GetView<SocialActivityController> {
  const SocialActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchSocialActivity();
      },
      child: Scaffold(
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
                child: Text('Add Social Activity', style: regulerText24),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 13),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Program Name
                      Text('Program Name', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Enter program name',
                        controller: controller.programController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter program name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Institution Name
                      Text('Institution Name', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Enter institution name',
                        controller: controller.institutionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter institution name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Role
                      Text('Role', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Enter role name',
                        controller: controller.roleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter role';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Start Date
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

                      // End Date
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

                      // Save and Clear Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileButton(
                            icon: Icon(Icons.save_outlined, color: neutral01Color),
                            text: 'Save',
                            onTap: () {
                              if (controller.validateForm()) {
                                // Construct the request object to save
                                if (controller.isEdit.value){
                                  SocialActivityRequest request = SocialActivityRequest(
                                    name: controller.programController.text,
                                    institutionName: controller.institutionController.text,
                                    role: controller.roleController.text,
                                    startDate: controller.formatDateRequest(controller.selectedStartDate.value ?? DateTime.now()),
                                    endDate: controller.formatDateRequest(controller.selectedEndDate.value ?? DateTime.now()),
                                  );
                                  controller.updateSocialActivity(request, controller.idCard.value);
                                  controller.isEdit.value = false;
                                  controller.idCard.value = 0;
                                } else {
                                  SocialActivityRequest request = SocialActivityRequest(
                                    name: controller.programController.text,
                                    institutionName: controller.institutionController.text,
                                    role: controller.roleController.text,
                                    startDate: controller.formatDateRequest(controller.selectedStartDate.value ?? DateTime.now()),
                                    endDate: controller.formatDateRequest(controller.selectedEndDate.value ?? DateTime.now()),
                                  );
                                  controller.createSocialActivity(request);
                                }

                              }
                            },
                            color: primaryDarkBlueColor,
                          ),
                          const SizedBox(width: 10),
                          ProfileButton(
                            icon: Icon(Icons.close, color: neutral01Color),
                            color: secondaryRedColor,
                            text: 'Clear',
                            onTap: () {
                              controller.isEdit.value = false;
                              showCustomDialog(
                                content: 'Are you sure you want to clear all data entered?',
                                onConfirm: () {
                                  controller.clearAll();
                                  Get.back();
                                  customSnackbar('All data has been deleted successfully');
                                },
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Displaying social activity list
                      Obx(() => Column(
                        children: controller.socialActivityLists.map((activity) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ProfileCard(
                              title: activity.name!,
                              leftSubTitle: activity.institutionName!,
                              rightSubTitle: activity.role,
                              startDate: activity.startDate != null ? controller.formatDate(activity.startDate) : 'N/A',
                              endDate: activity.endDate != null ? controller.formatDate(activity.endDate) : 'N/A',
                              onTap1: () {
                                controller.isEdit.value = true;
                                controller.idCard.value = activity.id!;
                                controller.patchField(activity);
                              },// Populate fields for editing
                              onTap2: () => controller.deleteSocialAcitivty(activity.id!), // Assuming activity has an ID
                              onTap3: () {}, // Additional action, if necessary
                            ),
                          );
                        }).toList(),
                      )),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
