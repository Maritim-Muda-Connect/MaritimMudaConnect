import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: thirdGreyColor,
      body: Center(
        child: Image.asset("assets/gif/logo_gif.GIF", width: 300),
      ),
    );
  }
}
