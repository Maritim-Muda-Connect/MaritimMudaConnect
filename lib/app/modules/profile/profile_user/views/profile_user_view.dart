import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/profile/controllers/profile_controller.dart';

import '../../../../../themes.dart';
import '../controllers/profile_user_controller.dart';

class ProfileUserView extends GetView<ProfileUserController> {
  const ProfileUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: neutral02Color,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 135,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                              color: primaryDarkBlueColor,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/paternkartu.png"))),
                        ),
                        const SizedBox(height: 50),
                        Obx(
                              () =>
                              Text(
                                controller.generalData.value.user?.name ?? '',
                                style: semiBoldText24,
                                textAlign: TextAlign.center,
                              ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provinceOptions[controller
                                  .generalData.value.user?.provinceId
                                  .toString()] ??
                                  '',
                              style: regulerText16,
                            ),
                            SizedBox(
                                height: 20,
                                child: VerticalDivider(color: neutral04Color)),
                            Text(
                                DateFormat("dd MMMM yyyy").format(
                                    controller.generalData.value.user
                                        ?.dateOfBirth ?? DateTime.now()),
                                style: regulerText16),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 63, top: 5, right: 63, bottom: 20),
                          child: Obx(
                                () =>
                                Text(
                                  controller.generalData.value.user?.bio ??
                                      'No bio yet',
                                  style:
                                  regulerText10.copyWith(color: neutral04Color),
                                  textAlign: TextAlign.center,
                                ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 75,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: controller.generalData.value.user
                                      ?.photoLink !=
                                      null
                                      ? NetworkImage(
                                      profileController.photoImage.value)
                                      : const AssetImage(
                                      'assets/images/default_photo.jpg')
                                  as ImageProvider,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Information",
                      style: semiBoldText24.copyWith(color: neutral04Color),
                    ),
                    const SizedBox(height: 21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 20,
                              color: subTitleColor,
                            ),
                            const SizedBox(width: 7),
                            Text("Email",
                                style: regulerText12.copyWith(
                                    color: subTitleColor)),
                          ],
                        ),
                        Text(controller.email.value,
                            style:
                            regulerText12.copyWith(color: neutral04Color))
                      ],
                    ),
                    const SizedBox(height: 27),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 20,
                              color: subTitleColor,
                            ),
                            const SizedBox(width: 7),
                            Text("Joined",
                                style: regulerText12.copyWith(
                                    color: subTitleColor)),
                          ],
                        ),
                        Text(controller.createdAt.value,
                            style:
                            regulerText12.copyWith(color: neutral04Color))
                      ],
                    ),
                    const SizedBox(height: 27),
                    Divider(color: neutral04Color),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("First Expertise",
                            style:
                            mediumText16.copyWith(color: neutral04Color)),
                        Text(
                            expertiseOptions[controller
                                .generalData.value.user?.firstExpertiseId
                                .toString()] ??
                                "",
                            style: regulerText10.copyWith(color: subTitleColor))
                      ],
                    ),
                    const SizedBox(height: 7),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Second Expertise",
                            style:
                            mediumText16.copyWith(color: neutral04Color)),
                        Text(
                            expertiseOptions[controller
                                .generalData.value.user?.secondExpertiseId
                                .toString()] ??
                                "",
                            style: regulerText10.copyWith(color: subTitleColor))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Achievement",
                      style: semiBoldText24.copyWith(color: neutral04Color),
                    ),
                    const SizedBox(height: 15),

                    // Achievement List with Dot
                    Obx(() {
                      final achievements =
                          controller.achievmentsController.achievementsData;
                      if (achievements.isEmpty) {
                        return Text(
                          "No achievements yet.",
                          style: regulerText12.copyWith(color: subTitleColor),
                        );
                      }
                      return Column(
                        children: achievements.map((achievement) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.circle,
                                  size: 8, color: neutral04Color), // Dot icon
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      achievement.awardName ?? '',
                                      style: mediumText16.copyWith(
                                          color: neutral04Color),
                                    ),
                                    Text(
                                      "${achievement.eventName ??
                                          ''} - ${achievement.achievedAt != null
                                          ? achievement.achievedAt!
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0]
                                          : ''}",
                                      style: regulerText12.copyWith(
                                          color: subTitleColor),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
