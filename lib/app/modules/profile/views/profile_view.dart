import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:maritimmuda_connect/app/modules/profile/widgets/avatar_general.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/profile_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  void _showDeleteConfirmationDialog(BuildContext context) {
    controller.clearDeleteConfirm();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Confirm Deletion", style: boldText16),
              const SizedBox(height: 16),
              Text(
                "Are you sure you want to delete your account? This action is irreversible. Please type 'DELETE' to confirm.",
                style: regulerText12,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.deleteConfirmInputController,
                hintText: "TYPE 'DELETE'",
                onChanged: (value) => controller.validateDeleteConfirm(value),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryDarkBlueColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel",
                          style: semiBoldText12.copyWith(
                              color: primaryDarkBlueColor)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryRedColor,
                          disabledBackgroundColor: neutral03Color,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        onPressed: controller.isDeleteConfirmValid.value
                            ? () {
                                Navigator.of(context).pop();
                                controller.confirmDeleteAccount();
                              }
                            : null,
                        child: Text("Delete",
                            style:
                                semiBoldText12.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: primaryDarkBlueColor,
      onRefresh: () async {
        await controller.fetchGeneral();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset:
            false, // Mencegah tampilan naik saat keyboard muncul
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
                                        File(
                                            controller.identityImagePath.value),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Student Card / Business Card', style: boldText12),
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
                                                  "Input Academic or Professional ID",
                                                  style: semiBoldText12,
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
                      Divider(color: neutral02Color, thickness: 1),
                      const SizedBox(height: 16),
                      Text('Delete Account',
                          style: boldText16.copyWith(color: secondaryRedColor)),
                      const SizedBox(height: 16),
                      Text('Reason (Optional)', style: boldText12),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: controller.deleteReasonController,
                        hintText: "Reason for deletion",
                      ),
                      const SizedBox(height: 16),
                      Text('Confirm Password', style: boldText12),
                      const SizedBox(height: 8),
                      Obx(
                        () => CustomTextField(
                          controller: controller.deletePasswordController,
                          hintText: "Enter your password",
                          obscureText: controller.isDeletePasswordHidden.value,
                          onChanged: (value) =>
                              controller.validateDeletePassword(value),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                controller.toggleDeletePasswordVisibility(),
                            icon: Icon(
                              controller.isDeletePasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: neutral03Color,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => CustomButton(
                          text: "Request Account Deletion",
                          height: 45,
                          onPressed: controller.isDeletePasswordFilled.value
                              ? () {
                                  controller.requestDeleteAccount(
                                    onSuccess: () =>
                                        _showDeleteConfirmationDialog(context),
                                  );
                                }
                              : null,
                          color: controller.isDeletePasswordFilled.value
                              ? secondaryRedColor
                              : neutral03Color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
