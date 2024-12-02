import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/main_drawer_controller.dart';

class MainDrawerView extends GetView<MainDrawerController> {
  const MainDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: neutral01Color,
          resizeToAvoidBottomInset: false,
          body: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.screens,
            ),
          ),
        ),
      ],
    );
  }
}
