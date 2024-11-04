import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/researches_request.dart';
import 'package:maritimmuda_connect/app/modules/profile/researches/controllers/researches_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../widget/custom_dialog.dart';

class ResearchesView extends GetView<ResearchesController> {
  const ResearchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchResearches();
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
                padding: const EdgeInsets.only(left: 15),
                child: Text('Add Researches', style: regulerText24),
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
                      Text('Title of Research', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Enter title of research name',
                        controller: controller.researchTitleC,
                      ),
                      const SizedBox(height: 16),
                      Text('Role', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Enter role name',
                        controller: controller.roleC,
                      ),
                      const SizedBox(height: 16),
                      Text('Affiliation Name', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Enter affiliation name',
                        controller: controller.affiliationC,
                      ),
                      const SizedBox(height: 16),
                      Text('Sponsor Name', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: 'Enter sponsor name',
                        controller: controller.sponsorC,
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
                            suffixIcon: Icon(Icons.calendar_today,
                                color: primaryBlueColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('End Date', style: boldText12),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileButton(
                            text: 'Save',
                            color: primaryDarkBlueColor,
                            icon: Icon(
                              Icons.save_outlined,
                              color: neutral01Color,
                            ),
                            onTap: () {
                              if (controller.validateForm()) {
                                if (controller.isEdit.value) {
                                  controller.updateResearche(
                                    ResearchesRequest(
                                      name: controller.researchTitleC.text,
                                      role: controller.roleC.text,
                                      institutionName:
                                          controller.affiliationC.text,
                                      sponsorName: controller.sponsorC.text,
                                      startDate: controller.formatDateRequest(
                                          controller.selectedStartDate.value ??
                                              DateTime.now()),
                                      endDate: controller.formatDateRequest(
                                          controller.selectedEndDate.value ??
                                              DateTime.now()),
                                    ),
                                    controller.idCard.value,
                                  );
                                  controller.isEdit.value = false;
                                  controller.idCard.value = 0;
                                } else {
                                  controller.createResearche(
                                    ResearchesRequest(
                                      name: controller.researchTitleC.text,
                                      role: controller.roleC.text,
                                      institutionName:
                                          controller.affiliationC.text,
                                      sponsorName: controller.sponsorC.text,
                                      startDate: controller.formatDateRequest(
                                          controller.selectedStartDate.value ??
                                              DateTime.now()),
                                      endDate: controller.formatDateRequest(
                                          controller.selectedEndDate.value ??
                                              DateTime.now()),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
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
                                content:
                                    'Are you sure you want to clear all data entered?',
                                onConfirm: () {
                                  controller.clearAll();
                                  controller.isEdit.value = false;
                                  Get.back();
                                  customSnackbar(
                                      'All data has been deleted successfully');
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
                          } else if (controller.researcheLists.isEmpty) {
                            return const SizedBox.shrink();
                          } else {
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                              itemCount: controller.researcheLists.length,
                              itemBuilder: (context, index) {
                                final researcheData =
                                    controller.researcheLists[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: ProfileCard(
                                    title: researcheData.name ?? '',
                                    rightTitle: researcheData.role ?? '',
                                    leftSubTitle:
                                        researcheData.institutionName ?? '',
                                    rightSubTitle:
                                        researcheData.sponsorName ?? '',
                                    startDate: controller
                                        .formatDate(researcheData.startDate),
                                    endDate: controller
                                        .formatDate(researcheData.endDate),
                                    onTap1: () {
                                      controller.isEdit.value = true;
                                      controller.idCard.value =
                                          researcheData.id ?? 0;
                                      controller.patchField(researcheData);
                                    },
                                    onTap2: () {
                                      showCustomDialog(
                                        content:
                                            'Are you sure you want to delete this data?',
                                        onConfirm: () {
                                          controller.deleteResearche(
                                              researcheData.id ?? 0);
                                          Get.back();
                                        },
                                        onCancel: () {
                                          Get.back();
                                        },
                                      );
                                    },
                                    onTap3: () {},
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
