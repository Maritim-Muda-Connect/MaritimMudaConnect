import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../widget/custom_dialog.dart';
import '../controllers/profile_controller.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/profile_button.dart';
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: neutral02Color,
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SingleChildScrollView(
                controller: controller.scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Stack(
                        children: [
                          Obx(
                            () {
                              if (controller.photoImagePath.value.isEmpty) {
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      Image.network(controller.photoImage.value)
                                          .image,
                                );
                              } else {
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(
                                    File(controller.photoImagePath.value),
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
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.media,
                                  allowMultiple: false,
                                );
                                if (result != null) {
                                  controller.photoImagePath.value =
                                      result.files.single.path!;
                                  controller.photoImageName.value =
                                      result.files.single.name;
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: primaryBlueColor,
                                radius: 18,
                                child: Icon(Icons.edit,
                                    color: neutral01Color, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                  // FilePickerResult? result =
                                  //     await FilePicker.platform.pickFiles(
                                  //   type: FileType.media,
                                  //   allowMultiple: false,
                                  // );
                                  // if (result != null) {
                                  //   controller.identityImagePath.value =
                                  //       result.files.single.path!;
                                  //   controller.identityImageName.value =
                                  //       result.files.single.name;
                                  // }
                                },
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: neutral02Color,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:
                                      controller.studentImagePath.value.isEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                "assets/images/student_card.png",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.file(
                                                File(controller
                                                    .studentImagePath.value),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                  // const Center(
                                  //     child: Icon(Icons.add_photo_alternate,
                                  //         size: 50, color: Colors.grey),
                                  //   ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                                  child: controller
                                          .identityImagePath.value.isEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: controller.photoIdentity.value
                                                  .contains("via")
                                              ? Image.asset(
                                                  "assets/images/process_identity.png",
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                )
                                              : Image.network(
                                                  controller
                                                      .photoIdentity.value,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.file(
                                            File(controller
                                                .identityImagePath.value),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),

                                  // const Center(
                                  //     child: Icon(Icons.add_photo_alternate,
                                  //         size: 50, color: Colors.grey),
                                  //   ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text('Name', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            controller: controller.nameController,
                            hintText: 'Enter your name',
                          ),
                          const SizedBox(height: 16),
                          Text('Email', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
                            hintText: 'Enter your email',
                            readOnly: true,
                          ),
                          const SizedBox(height: 16),
                          Text('Gender', style: boldText12),
                          const SizedBox(height: 8),
                          Obx(
                            () => CustomDropdown(
                              hintText: 'Choose your gender',
                              options: controller.genderOptions,
                              selectedOption: controller.genderOptions[
                                  controller.selectedGender.value],
                              onSelected: (String? value) {
                                controller.setGender(value);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('Provincial Organization', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: controller.provincialOrgController,
                            hintText: 'Enter provincial organization',
                            readOnly: true,
                          ),
                          const SizedBox(height: 16),
                          Text('Place of Birth', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: controller.placeOfBirthController,
                            hintText: 'Enter place of birth',
                          ),
                          const SizedBox(height: 16),
                          Text('Date of Birth', style: boldText12),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => controller.selectDate(context),
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: controller.dateOfBirthController,
                                hintText: 'Select date of birth',
                                suffixIcon: Icon(Icons.calendar_today,
                                    color: primaryBlueColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('LinkedIn', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: controller.linkedInController,
                            hintText: 'Enter LinkedIn profile URL',
                          ),
                          const SizedBox(height: 16),
                          Text('Instagram', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: controller.instagramController,
                            hintText: 'Enter Instagram profile URL',
                          ),
                          const SizedBox(height: 16),
                          Text('First Expertise', style: boldText12),
                          const SizedBox(height: 8),
                          Obx(
                            () => CustomDropdown(
                              hintText: 'Choose your first expertise',
                              options: firstExpertise,
                              selectedOption: firstExpertise[
                                  controller.selectedFirstExpertise.value],
                              onSelected: (String? value) {
                                controller.setFirstExpertise(value);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('Second Expertise', style: boldText12),
                          const SizedBox(height: 8),
                          Obx(
                            () => CustomDropdown(
                              hintText: 'Choose your second expertise',
                              options: secondExpertise,
                              selectedOption: secondExpertise[
                                  controller.selectedSecondExpertise.value],
                              onSelected: (String? value) {
                                controller.setSecondExpertise(value);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('Address', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            inputAction: TextInputAction.done,
                            maxLines: 5,
                            controller: controller.addressController,
                            hintText: 'Enter address',
                          ),
                          const SizedBox(height: 16),
                          Text('Residence Address', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            inputAction: TextInputAction.done,
                            maxLines: 5,
                            controller: controller.residenceAddressController,
                            hintText: 'Enter residence address',
                          ),
                          const SizedBox(height: 16),
                          Text('Bio', style: boldText12),
                          const SizedBox(height: 8),
                          CustomTextField(
                            inputAction: TextInputAction.done,
                            maxLines: 5,
                            controller: controller.bioController,
                            hintText: 'Enter your bio',
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProfileButton(
                                  onTap: () async {
                                    controller.updateGeneral(
                                      GeneralRequest(
                                        name: controller.nameController.text,
                                        linkedinProfile:
                                            controller.linkedInController.text,
                                        instagramProfile:
                                            controller.instagramController.text,
                                        gender: controller.selectedGender.value,
                                        placeOfBirth: controller
                                            .placeOfBirthController.text,
                                        dateOfBirth: controller
                                            .dateOfBirthController.text,
                                        firstExpertiseId: controller
                                            .selectedFirstExpertise.value,
                                        secondExpertiseId: controller
                                            .selectedSecondExpertise.value,
                                        permanentAddress:
                                            controller.addressController.text,
                                        residenceAddress: controller
                                            .residenceAddressController.text,
                                        bio: controller.bioController.text,
                                      ),
                                      File(controller.photoImagePath.value),
                                      File(controller.identityImagePath.value),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.save_outlined,
                                    color: neutral01Color,
                                  ),
                                  color: primaryDarkBlueColor,
                                  text: 'Save',
                                ),
                              ),
                              ProfileButton(
                                icon: Icon(
                                  Icons.close,
                                  color: neutral01Color,
                                ),
                                color: secondaryRedColor,
                                text: 'Clear',
                                onTap: () {
                                  showCustomDialog(
                                    content:
                                        'Are you sure you want to clear all data entered?',
                                    onConfirm: () {
                                      Get.back();
                                      customSnackbar(
                                          "All data has been cleared");
                                    },
                                    onCancel: () {
                                      Get.back();
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? Container(color: Colors.black.withOpacity(0.3))
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isLoading.value
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 32),
                    decoration: BoxDecoration(
                      color: neutral01Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        CircularProgressIndicator(color: primaryDarkBlueColor),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
