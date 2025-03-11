import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/widgets/avatar_general.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: primaryDarkBlueColor,
      onRefresh: () async {
        await controller.fetchGeneral();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false, // Mencegah tampilan naik saat keyboard muncul
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(child: AvatarGeneral(controller: controller)),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Identity Card', style: boldText12),
                      const SizedBox(height: 8),
                      Obx(
                        () => DottedBorder(
                          dashPattern: const [10],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          padding: const EdgeInsets.all(6),
                          child: InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.media,
                                allowMultiple: false,
                              );
                              if (result != null) {
                                controller.identityImagePath.value =
                                    result.files.single.path!;
                                controller.identityImageName.value =
                                    result.files.single.name;
                              }
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: neutral02Color,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: controller.identityImagePath.value.isEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: controller.photoIdentity.value
                                                  .contains("via") ||
                                              controller.photoIdentity.value
                                                  .contains("cloudinary")
                                          ? Image.asset(
                                              "assets/images/process_identity.png",
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            )
                                          : Image.network(
                                              controller.photoIdentity.value,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(controller.identityImagePath.value),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Student Card', style: boldText12),
                      const SizedBox(height: 8),
                      Obx(
                        () => DottedBorder(
                          dashPattern: const [10],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          padding: const EdgeInsets.all(6),
                          child: InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.media,
                                allowMultiple: false,
                              );
                              if (result != null) {
                                controller.paymentImagePath.value =
                                    result.files.single.path!;
                                controller.paymentImageName.value =
                                    result.files.single.name;
                              }
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: neutral02Color,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: controller.paymentImagePath.value.isEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: controller.photoPayment.value
                                                  .contains("via") ||
                                              controller.photoPayment.value
                                                  .contains('cloudinary')
                                          ? SizedBox(
                                              width: double.infinity,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Input Payment Confirmation",
                                                  style: boldText12,
                                                ),
                                              ),
                                            )
                                          : Image.network(
                                              controller.photoPayment.value,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(controller.paymentImagePath.value),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Ruang untuk FAB agar tidak tertutup
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Aksi untuk edit profil atau lainnya
          },
          backgroundColor: primaryDarkBlueColor,
          shape: const CircleBorder(),
          child: Icon(Icons.edit, color: neutral01Color),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              IconButton(icon: Icon(Icons.analytics), onPressed: () {}),
              const SizedBox(width: 48), // Beri ruang untuk FAB di tengah
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}