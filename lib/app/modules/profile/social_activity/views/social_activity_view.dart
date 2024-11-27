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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: neutral02Color,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchSocialActivity();
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
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
                        Text('Program Name', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          focusNode: controller.focusNodes[0],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(
                                controller.focusNodes[1]);
                          },
                          hintText: 'Enter program name',
                          controller: controller.programController,
                          validator: controller.validateProgramName,
                        ),
                        const SizedBox(height: 16),

                        Text('Institution Name', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          focusNode: controller.focusNodes[1],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(
                                controller.focusNodes[2]);
                          },
                          hintText: 'Enter institution name',
                          controller: controller.institutionController,
                          validator: controller.validateInstitutionName,
                        ),
                        const SizedBox(height: 16),

                        Text('Role', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          focusNode: controller.focusNodes[2],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(
                                controller.focusNodes[3]);
                          },
                          hintText: 'Enter role name',
                          controller: controller.roleController,
                          validator: controller.validateRole,
                        ),
                        const SizedBox(height: 16),

                        Text('Start Date', style: boldText12),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => controller.selectStartDate(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              validator: controller.validateStartDate,
                              controller: controller.startDateController,
                              hintText: 'Select start date',
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: primaryDarkBlueColor),
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
                              validator: controller.validateEndDate,
                              controller: controller.endDateController,
                              hintText: 'Select end date',
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: primaryDarkBlueColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ProfileButton(
                              icon: Icon(
                                  Icons.save_outlined, color: neutral01Color),
                              text: 'Save',
                              onTap: () {
                                if (controller.validateForm()) {
                                  if (controller.isEdit.value) {
                                    SocialActivityRequest request = SocialActivityRequest(
                                      name: controller.programController.text,
                                      institutionName: controller
                                          .institutionController.text,
                                      role: controller.roleController.text,
                                      startDate: controller.formatDateRequest(
                                          controller.selectedStartDate.value ??
                                              DateTime.now()),
                                      endDate: controller.formatDateRequest(
                                          controller.selectedEndDate.value ??
                                              DateTime.now()),
                                    );
                                    controller.updateSocialActivity(
                                        request, controller.idCard.value);
                                    controller.isEdit.value = false;
                                    controller.idCard.value = 0;
                                  } else {
                                    SocialActivityRequest request = SocialActivityRequest(
                                      name: controller.programController.text,
                                      institutionName: controller
                                          .institutionController.text,
                                      role: controller.roleController.text,
                                      startDate: controller.formatDateRequest(
                                          controller.selectedStartDate.value ??
                                              DateTime.now()),
                                      endDate: controller.formatDateRequest(
                                          controller.selectedEndDate.value ??
                                              DateTime.now()),
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
                                if (controller.checkField()) {
                                  customSnackbar(
                                    "All field already empty",
                                    secondaryRedColor,
                                  );
                                } else {
                                  showCustomDialog(
                                    content:
                                    'Are you sure you want to clear all data entered?',
                                    onConfirm: () {
                                      controller.clearAll();
                                      controller.isEdit(false);
                                      Get.back();
                                      customSnackbar(
                                          'All data has been deleted successfully');
                                    },
                                    onCancel: () {
                                      Get.back();
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        Obx(() =>
                            Column(
                              children: controller.socialActivityLists.map((
                                  activity) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: ProfileCard(
                                      title: activity.name!,
                                      leftSubTitle: activity.institutionName!,
                                      rightSubTitle: activity.role,
                                      startDate: activity.startDate != null
                                          ? controller.formatDate(
                                          activity.startDate)
                                          : 'N/A',
                                      endDate: activity.endDate != null
                                          ? controller.formatDate(
                                          activity.endDate)
                                          : 'N/A',
                                      onTap1: () {
                                        controller.isEdit.value = true;
                                        controller.idCard.value = activity.id!;
                                        controller.patchField(activity);
                                        controller.scrollController.animateTo(
                                          0.0,
                                          duration:
                                          const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      onTap2: () =>
                                          showCustomDialog(
                                              content: 'Are you sure want to delete this data?',
                                              onConfirm: () {
                                                controller.deleteSocialAcitivty(activity.id!);
                                                Get.back();
                                              },
                                              onCancel: () {
                                                Get.back();
                                              }),
                                      onTap3: ()
                                  {},
                                ),);
                              }).toList(),
                            )),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
