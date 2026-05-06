import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/themes.dart';

void customSnackbar(String text, [Color? color]) {
  if (Get.context != null) {
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: mediumText12.copyWith(
                  fontSize: 14,
                  color: neutral01Color,
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
              },
              child: Text(
                "Close",
                style: mediumText12.copyWith(
                  fontSize: 14,
                  color: neutral01Color,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color ?? primaryDarkBlueColor,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        elevation: 0,
      ),
    );
  }
}
