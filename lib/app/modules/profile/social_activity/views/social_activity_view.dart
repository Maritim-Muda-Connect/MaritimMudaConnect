import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/social_activity/controllers/social_activity_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../../../widget/custom_dialog.dart';



class SocialActivityView extends GetView<SocialActivityController> {
  const SocialActivityView({super.key});

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
                child: Text('Add Social Activity',
                    style: regulerText24),
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
                        Text('Program Name', style: boldText12,),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter program name',
                          controller: controller.programController,
                        ),
                        const SizedBox(height: 16),
                        Text('Institution Name', style: boldText12,),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter institution name',
                          controller: controller.institutionController,
                        ),
                        const SizedBox(height: 16),
                        Text('Role', style: boldText12,),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter role name',
                          controller: controller.roleController,
                        ),
                        const SizedBox(height: 16),
                        Text('Start Date', style: boldText12,),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => controller.selectStartDate(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller: controller.startDateController,
                              hintText: 'Select start date',
                              suffixIcon:
                              Icon(Icons.calendar_today, color: primaryBlueColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('End Date', style: boldText12,),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => controller.selectEndDate(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller: controller.endDateController,
                              hintText: 'Select end date',
                              suffixIcon:
                              Icon(Icons.calendar_today, color: primaryBlueColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ProfileButton(
                                icon: Icon(
                                  Icons.save_outlined,
                                  color: neutral01Color,
                                ),
                                text: 'Save',
                                onTap: controller.saveSocialActivity,
                                color: primaryDarkBlueColor),
                            const SizedBox(width: 10),
                            ProfileButton(
                                icon: Icon(
                                  Icons.close,
                                  color: neutral01Color,
                                ),
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
                                      onCancel: (){
                                        Get.back();
                                      });
                                }
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Obx(() => Column(
                          children: controller.socialActivity.asMap().entries.map((entry) {
                            int idx = entry.key;
                            SocialActivity exp = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: ProfileCard(
                                title: exp.program,
                                leftSubTitle: exp.institution,
                                rightSubTitle: exp.role,
                                startDate: exp.startDate,
                                endDate: exp.endDate,
                                onTap1: () {},
                                onTap2: () => controller.deleteSocialActivity(idx),
                                onTap3: () {},
                              ),
                            );
                          }).toList(),
                        )),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 50,
              )
            ],
          )),
    );
  }
}
