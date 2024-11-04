import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/organizations_request.dart';
import 'package:maritimmuda_connect/app/modules/profile/organizations/controllers/organizations_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../widget/custom_dialog.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/profile_button.dart';

class OrganizationsView extends GetView<OrganizationsController> {
  const OrganizationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchOrganizations();
      },
      child: Scaffold(
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
                  'Add Organization Experience',
                  style: regulerText24,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
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
                        'Organization Name',
                        style: boldText12,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: controller.organizationNameC,
                        hintText: 'Enter your organization name',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Position',
                        style: boldText12,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextField(
                        controller: controller.positionC,
                        hintText: 'Enter your position',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Start Date',
                        style: boldText12,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () => controller.selectStartDate(context),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: controller.startDateController,
                            hintText: 'Select start date',
                            suffixIcon: Icon(Icons.calendar_today,
                                color: primaryBlueColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'End Date',
                        style: boldText12,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () => controller.selectEndDate(context),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: controller.endDateController,
                            hintText: 'Select end date',
                            suffixIcon: Icon(Icons.calendar_today,
                                color: primaryBlueColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
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
                                  controller.updateOrganizations(
                                    OrganizationsRequest(
                                        organizationName:
                                            controller.organizationNameC.text,
                                        role: controller.positionC.text,
                                        periodStartDate:
                                            controller.selectedStartDate.value,
                                        periodEndDate:
                                            controller.selectedEndDate.value),
                                    controller.idCard.value,
                                  );
                                  controller.isEdit.value = false;
                                  controller.idCard.value = 0;
                                } else {
                                  controller.createOrganizations(
                                    OrganizationsRequest(
                                        organizationName:
                                            controller.organizationNameC.text,
                                        role: controller.positionC.text,
                                        periodStartDate:
                                            controller.selectedStartDate.value,
                                        periodEndDate:
                                            controller.selectedEndDate.value),
                                  );
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
                                showCustomDialog(
                                    content:
                                        'Are you sure you want to clear all data entered?',
                                    onConfirm: () {
                                      controller.clearAll();
                                      Get.back();
                                      customSnackbar(
                                        'All data has been deleted successfully',
                                      );
                                    },
                                    onCancel: () {
                                      Get.back();
                                    });
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            return Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                    color: primaryDarkBlueColor),
                              ),
                            );
                          } else if (controller.organizationList.isEmpty) {
                            return const SizedBox.shrink();
                          } else {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.organizationList.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (context, index) {
                                final organizationsData =
                                    controller.organizationList[index];
                                return ProfileCard(
                                  title:
                                      organizationsData.organizationName ?? '',
                                  rightTitle: organizationsData.role ?? '',
                                  startDate: controller.formatDate(
                                      organizationsData.periodStartDate),
                                  endDate: controller.formatDate(
                                      organizationsData.periodEndDate),
                                  onTap1: () {
                                    controller.isEdit.value = true;
                                    controller.idCard.value =
                                        organizationsData.id ?? 0;
                                    controller.patchField(organizationsData);
                                  },
                                  onTap2: () {
                                    showCustomDialog(
                                      content:
                                          'Are you sure you want to delete this data?',
                                      onConfirm: () {
                                        controller.deleteOrganizations(
                                            organizationsData.id ?? 0);
                                        Get.back();
                                      },
                                      onCancel: () {
                                        Get.back();
                                      },
                                    );
                                  },
                                  onTap3: () {},
                                );
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
