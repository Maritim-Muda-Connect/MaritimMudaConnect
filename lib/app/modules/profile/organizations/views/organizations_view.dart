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
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
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
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10, right: 10),
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
                          validator: controller.validateOrganization,
                          focusNode: controller.focusNodes[0],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[1]);
                          },
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
                          validator: controller.validatePosition,
                          focusNode: controller.focusNodes[1],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[2]);
                          },
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
                                  color: primaryDarkBlueColor),
                              validator: controller.validateStartDate,
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
                                  color: primaryDarkBlueColor),
                              validator: controller.validateEndDate,
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
                                          periodStartDate: controller
                                              .selectedStartDate.value,
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
                                          periodStartDate: controller
                                              .selectedStartDate.value,
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
                                  if (controller.checkField()) {
                                    if (SnackbarController
                                            .isSnackbarBeingShown ==
                                        false) {
                                      customSnackbar(
                                        "All field already empty",
                                        secondaryRedColor,
                                      );
                                    }
                                  } else {
                                    showCustomDialog(
                                      content:
                                          'Are you sure you want to clear all data entered?',
                                      onConfirm: () {
                                        controller.clearAll();
                                        controller.isEdit.value = false;
                                        customSnackbar(
                                          'All data has been deleted successfully',
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      onCancel: () {
                                        Get.back();
                                      },
                                    );
                                  }
                                })
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(() => Column(
                              children:
                                  controller.organizationList.map((activity) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: ProfileCard(
                                    title: activity.organizationName!,
                                    leftSubTitle: activity.role!,
                                    startDate: activity.periodStartDate != null
                                        ? controller.formatDate(
                                            activity.periodStartDate)
                                        : 'N/A',
                                    endDate: activity.periodEndDate != null
                                        ? controller
                                            .formatDate(activity.periodEndDate)
                                        : 'N/A',
                                    onTap1: () {
                                      controller.isEdit.value = true;
                                      controller.idCard.value = activity.id!;
                                      controller.patchField(activity);
                                      controller.scrollController.animateTo(0,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut);
                                    },
                                    onTap2: () => showCustomDialog(
                                        content:
                                            'Are you sure you want to delete this data?',
                                        onConfirm: () {
                                          controller.deleteOrganizations(
                                              activity.id ?? 0);
                                          Get.back();
                                        },
                                        onCancel: () {
                                          Get.back();
                                        }),
                                    onTap3: () {},
                                  ),
                                );
                              }).toList(),
                            )),
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
