import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/views/e_kta_detail_view.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/views/scan_qr_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/e_kta_controller.dart';
import '../widgets/custom_indicator.dart';
import '../widgets/custom_slide_card.dart';

class EKtaView extends GetView<EKtaController> {
  const EKtaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        backgroundColor: neutral02Color,
        title: Text('E-KTA',
            style: semiBoldText16.copyWith(color: neutral04Color)),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getEkta();
        },
        color: primaryDarkBlueColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 21, top: 20, right: 21, bottom: 21),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello,",
                                style: regulerText26.copyWith(
                                    color: neutral04Color)),
                            Obx(() {
                              if (controller
                                  .ektaData.value.user!.name!.isNotEmpty) {
                                return Text(
                                  controller.ektaData.value.user?.name ?? "",
                                  style: semiBoldText32.copyWith(
                                      color: neutral04Color),
                                );
                              } else {
                                return const Text("");
                              }
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Obx(() {
                    if (controller
                        .ektaData.value.user!.memberCardPreview!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 237,
                            child: PageView(
                              onPageChanged: controller.onPageChanged,
                              children: [
                                CustomCardSlider(
                                  image: NetworkImage(controller
                                      .ektaData.value.user!.memberCardPreview!),
                                ),
                                const CustomCardSlider(
                                  image: AssetImage("assets/images/ekta.png"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomIndicator(controller: controller)
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text: "Download",
                        textSize: boldText16.copyWith(color: neutral01Color),
                        radius: 50,
                        onPressed: () {
                          if (!controller
                              .ektaData.value.user!.memberCardDocument!
                              .contains("cloudinary")) {
                            controller.launchURL(controller
                                .ektaData.value.user!.memberCardDocument!);
                          } else {
                            if (SnackbarController.isSnackbarBeingShown ==
                                false) {
                              customSnackbar(
                                  "E-KTA not yet generated", secondaryRedColor);
                            }
                          }
                        },
                        height: 43,
                        width: 130,
                        gradient: LinearGradient(
                          colors: [primaryDarkBlueColor, primaryBlueColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      CustomButton(
                        text: "Show QR",
                        textSize: boldText16.copyWith(color: neutral01Color),
                        radius: 50,
                        onPressed: () {
                          Get.to(
                            () => const EKtaDetailView(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 100),
                          );
                        },
                        height: 43,
                        width: 130,
                        gradient: LinearGradient(
                          colors: [primaryDarkBlueColor, primaryBlueColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      text: "Scan QR",
                      textSize: boldText16.copyWith(color: neutral01Color),
                      radius: 50,
                      onPressed: () {
                        Get.to(
                          () => const ScanQrView(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 100),
                        );
                      },
                      height: 43,
                      width: 130,
                      gradient: LinearGradient(
                        colors: [primaryDarkBlueColor, primaryBlueColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
