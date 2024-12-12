import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/controllers/profile_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

class AvatarGeneral extends StatelessWidget {
  const AvatarGeneral({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () {
            if (controller.photoImagePath.value.isEmpty) {
              return GestureDetector(
                onTap: () {
                  Get.dialog(
                    Dialog(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: CircleAvatar(
                        maxRadius: 180,
                        foregroundImage:
                            Image.network(controller.photoImage.value).image,
                        backgroundImage:
                            Image.network(controller.photoImage.value).image,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      Image.network(controller.photoImage.value).image,
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Get.dialog(
                    Dialog(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: CircleAvatar(
                        maxRadius: 180,
                        foregroundImage: FileImage(
                          File(controller.photoImagePath.value),
                        ),
                        backgroundImage: FileImage(
                          File(controller.photoImagePath.value),
                        ),
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                    File(controller.photoImagePath.value),
                  ),
                ),
              );
            }
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.media,
                allowMultiple: false,
              );
              if (result != null) {
                controller.photoImagePath.value = result.files.single.path!;
                controller.photoImageName.value = result.files.single.name;
              }
            },
            child: CircleAvatar(
              backgroundColor: primaryBlueColor,
              radius: 18,
              child: Icon(Icons.edit, color: neutral01Color, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
