import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/themes.dart';

void showCustomDialog({
  required String content,
  String confirmText = "Yes",
  String cancelText = "No",
  required VoidCallback? onConfirm,
  required VoidCallback? onCancel,
}) {
  Get.dialog(
    AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      content: Text(
        textAlign: TextAlign.center,
        content,
        style: regulerText12,
      ),
      backgroundColor: neutral01Color,
      actions: [
        SizedBox(
          width: 80,
          height: 30,
          child: ElevatedButton(
            onPressed: onCancel ?? () => Get.back(),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(neutral01Color),
              side: WidgetStateProperty.all<BorderSide>(
                  BorderSide(color: primaryDarkBlueColor)),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
            ),
            child: Text(
              cancelText,
              style: mediumText12.copyWith(color: primaryDarkBlueColor),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          height: 30,
          child: ElevatedButton(
            onPressed: onConfirm ?? () => Get.back(),
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(primaryDarkBlueColor),
              side: WidgetStateProperty.all<BorderSide>(
                  BorderSide(color: primaryDarkBlueColor)),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
            ),
            child: Text(
              confirmText,
              style: mediumText12.copyWith(color: neutral01Color),
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
