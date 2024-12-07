import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/e_kta/controllers/e_kta_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

class EKtaDetailView extends GetView<EKtaController> {
  const EKtaDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final EKtaController ektaController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutral02Color,
        title: Text(
          'QR',
          style: semiBoldText16.copyWith(color: neutral04Color),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryBlueColor, primaryDarkBlueColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'Hero',
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage(
                            ektaController.ektaData.value.user?.photoLink ??
                                controller.defaultAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: neutral04Color.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: neutral01Color,
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SvgPicture.string(
                              String.fromCharCodes(
                                  base64Decode(ektaController.svgString)),
                              width: constraints.maxWidth * 0.95,
                              height: constraints.maxWidth * 0.95,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Hero(
                        tag: 'herotag',
                        child: Text(
                          ektaController.ektaData.value.user?.name ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: semiBoldText22.copyWith(color: neutral01Color),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
