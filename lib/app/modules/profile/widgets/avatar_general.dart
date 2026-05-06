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
                      child: ClipOval(
                        child: SizedBox(
                          width: 360,
                          height: 360,
                          child: Image.network(
                            controller.photoImage.value,
                            key: ValueKey(controller.refreshKey.value),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(child: Icon(Icons.person, size: 100, color: Colors.grey)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: ClipOval(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      controller.photoImage.value,
                      key: ValueKey(controller.refreshKey.value),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey[300], child: const Icon(Icons.person, size: 50, color: Colors.grey)),
                    ),
                  ),
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
