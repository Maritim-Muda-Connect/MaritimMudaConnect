import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/e_kta_controller.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.controller,
  });

  final EKtaController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2, // Change this to the number of cards you have
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.currentPage.value == index
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ),
        ));
  }
}
