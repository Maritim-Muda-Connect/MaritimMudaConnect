import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/views/e_kta_detail_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../controllers/e_kta_controller.dart';
import '../widgets/custom_indicator.dart';
import '../widgets/custom_slide_card.dart';

class EKtaView extends GetView<EKtaController> {
  const EKtaView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EKtaController());
    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        title: Text('E-KTA',
            style: semiBoldText16.copyWith(color: neutral04Color)),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
      ),
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 21, top: 20, right: 21, bottom: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello,",
                    style: regulerText26.copyWith(color: neutral04Color)),
                Text("Komeng Uhuy",
                    style: semiBoldText32.copyWith(color: neutral04Color))
              ],
            ),
            Column(
              children: [
                Container(
                  height: 237,
                  child: PageView(
                    onPageChanged: controller.onPageChanged,
                    children: const [
                      CustomCardSlider(),
                      CustomCardSlider(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CustomIndicator(controller: controller)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: "Download",
                  textSize: boldText16.copyWith(color: neutral01Color),
                  radius: 50,
                  onPressed: () {},
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
                    Get.to(() => EKtaDetailView());
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
          ],
        ),
      )),
    );
  }
}
