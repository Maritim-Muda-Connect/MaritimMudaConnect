import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/result_qr_controller.dart';

class ResultQrView extends GetView<ResultQrController> {
  const ResultQrView({super.key, this.uid});

  final String? uid;
  @override
  Widget build(BuildContext context) {
    controller.fetchMemberQr(uid ?? "");
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: neutral02Color,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                width: 403,
                decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
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
                              bottomRight: Radius.circular(16),
                            ),
                            color: primaryDarkBlueColor,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/paternkartu.png"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Obx(
                          () {
                            if (controller.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: primaryDarkBlueColor,
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    controller.memberQrData.value.user?.name ??
                                        "",
                                    style: semiBoldText24,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          provinceOptions[controller
                                                  .memberQrData
                                                  .value
                                                  .user
                                                  ?.provinceId
                                                  .toString()] ??
                                              "",
                                          style: regulerText16,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: VerticalDivider(
                                            color: neutral04Color),
                                      ),
                                      Text(
                                        controller.memberQrData.value.user
                                                ?.email ??
                                            "",
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 63,
                                        top: 5,
                                        right: 63,
                                        bottom: 20),
                                    child: Text(
                                      controller.memberQrData.value.user?.bio ??
                                          "",
                                      style: regulerText10.copyWith(
                                          color: neutral04Color),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Positioned(
                      top: 75,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            if (controller.memberQrData.value.user!.photoLink!
                                .isNotEmpty) {
                              return CircleAvatar(
                                minRadius: 50,
                                foregroundImage: NetworkImage(controller
                                        .memberQrData.value.user?.photoLink ??
                                    controller.defaultAvatar),
                                backgroundImage: const AssetImage(
                                    'assets/images/default_photo.jpg'),
                              );
                            } else {
                              return CircleAvatar(
                                minRadius: 50,
                                foregroundImage:
                                    NetworkImage(controller.defaultAvatar),
                                backgroundImage: const AssetImage(
                                    'assets/images/default_photo.jpg'),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 29),
              Obx(
                () {
                  if (controller.isLoading.value) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: primaryDarkBlueColor));
                  }
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 14, right: 14, bottom: 14),
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
                                  color: subTitleColor,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  "Email",
                                  style: regulerText12.copyWith(
                                      color: subTitleColor),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Text(
                                controller.memberQrData.value.user?.email ?? "",
                                style: regulerText14.copyWith(
                                    color: neutral04Color),
                                maxLines: 2,
                              ),
                            )
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
                                  color: subTitleColor,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  "Joined",
                                  style: regulerText12.copyWith(
                                      color: subTitleColor),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat('MMMM yyyy', 'id_ID').format(
                                controller.memberQrData.value.user
                                        ?.emailVerifiedAt ??
                                    DateTime.now(),
                              ),
                              style:
                                  regulerText16.copyWith(color: neutral04Color),
                            )
                          ],
                        ),
                        const SizedBox(height: 27),
                        Divider(color: neutral04Color),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("First Expertise",
                                style: mediumText16.copyWith(
                                    color: neutral04Color)),
                            Text(
                              expertiseOptions[controller
                                      .memberQrData.value.user?.firstExpertiseId
                                      .toString()] ??
                                  "Not set",
                              style:
                                  regulerText10.copyWith(color: subTitleColor),
                            )
                          ],
                        ),
                        const SizedBox(height: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Second Expertise",
                                style: mediumText16.copyWith(
                                    color: neutral04Color)),
                            Text(
                              expertiseOptions[controller.memberQrData.value
                                      .user?.secondExpertiseId
                                      .toString()] ??
                                  "Not set",
                              style:
                                  regulerText10.copyWith(color: subTitleColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
