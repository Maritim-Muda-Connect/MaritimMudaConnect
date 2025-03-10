import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/achievements_request.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../../../widget/custom_dialog.dart';
import '../../../widget/custom_snackbar.dart';
import '../controllers/achievements_controller.dart';

class AchievementsView extends GetView<AchievementsController> {
  const AchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchAchievements();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: neutral02Color,
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
                  child: Text('Add Achievement History', style: regulerText24),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                      color: neutral01Color,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 13),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Award/accomplishment',
                          style: boldText12,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter award name',
                          controller: controller.awardC,
                          validator: controller.validateAward,
                          focusNode: controller.focusNodes[0],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[1]);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Appreciator/Organizer',
                          style: boldText12,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter appreciator name',
                          controller: controller.appreciatorC,
                          validator: controller.validateAppreciator,
                          focusNode: controller.focusNodes[1],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[2]);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Event Name',
                          style: boldText12,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter event name',
                          controller: controller.eventNameC,
                          validator: controller.validateEventName,
                          focusNode: controller.focusNodes[2],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[3]);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Event Level',
                          style: boldText12,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter event level',
                          controller: controller.eventLevelC,
                          validator: controller.validateEventLevel,
                          focusNode: controller.focusNodes[3],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Date of Achievement',
                          style: boldText12,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => controller.selectDate(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller: controller.dateC,
                              hintText: 'Select date of achievement',
                              validator: controller.validateDate,
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
                              color: primaryDarkBlueColor,
                              icon: Icon(
                                Icons.save_outlined,
                                color: neutral01Color,
                              ),
                              text: 'Save',
                              onTap: () {
                                if (controller.validateForm()) {
                                  if (controller.isEdit.value) {
                                    controller.updateAchievements(
                                        AchievementsRequest(
                                          awardName: controller.awardC.text,
                                          appreciator:
                                              controller.appreciatorC.text,
                                          eventName: controller.eventNameC.text,
                                          eventLevel:
                                              controller.eventLevelC.text,
                                          achievedAt: controller.formatDate(
                                            controller.selectedDate.value ??
                                                DateTime.now(),
                                          ),
                                        ),
                                        controller.idCard.value);
                                    controller.isEdit.value = false;
                                    controller.idCard.value = 0;
                                  } else {
                                    controller.createAchievements(
                                      AchievementsRequest(
                                          awardName: controller.awardC.text,
                                          appreciator:
                                              controller.appreciatorC.text,
                                          eventName: controller.eventNameC.text,
                                          eventLevel:
                                              controller.eventLevelC.text,
                                          achievedAt: controller.formatDate(
                                              controller.selectedDate.value ??
                                                  DateTime.now())),
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
                                if (controller.checkField()) {
                                  if (SnackbarController.isSnackbarBeingShown ==
                                      false) {
                                    customSnackbar(
                                      "All field already empty",
                                      secondaryRedColor,
                                    );
                                  }
                                } else {
                                  showCustomDialog(
                                    content:
                                        'Are you sure want to clear all data entered?',
                                    onConfirm: () {
                                      controller.clearAll();
                                      Get.back();
                                      customSnackbar(
                                        'All data has been deleted successfully',
                                      );
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
                            } else if (controller.achievementsData.isEmpty) {
                              return const SizedBox.shrink();
                            } else {
                              return ListView.separated(
                                padding: const EdgeInsets.only(bottom: 20),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 20,
                                ),
                                itemCount: controller.achievementsData.length,
                                itemBuilder: (context, index) {
                                  final achievementsData =
                                      controller.achievementsData[index];
                                  return ProfileCard(
                                    title: achievementsData.eventName ?? '',
                                    rightTitle: achievementsData.eventLevel,
                                    leftSubTitle: achievementsData.awardName,
                                    startDate:
                                        achievementsData.achievedAt != null
                                            ? controller.formatDate(
                                                achievementsData.achievedAt)
                                            : 'N/A',
                                    imageUrl: '',
                                    onTap1: () {
                                      controller.isEdit.value = true;
                                      controller.idCard.value =
                                          achievementsData.id ?? 0;
                                      controller.patchField(achievementsData);
                                      controller.scrollController.animateTo(
                                        0.0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    onTap2: () {
                                      showCustomDialog(
                                        content:
                                            'Are you sure you want to delete this data?',
                                        onConfirm: () {
                                          controller.deleteAchievements(
                                              achievementsData.id ?? 0);
                                          Navigator.of(context).pop();
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
