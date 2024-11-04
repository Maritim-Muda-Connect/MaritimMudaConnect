import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/utils/expertises.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
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
      onRefresh: () async {
        await controller.fetchGeneral();
      },
      child: Scaffold(
        backgroundColor: neutral02Color,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Stack(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            controller.profileImageFile.value != null
                                ? FileImage(controller.profileImageFile.value!)
                                : const AssetImage('assets/images/profile.png')
                                    as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: false,
                          );
                          if (result != null && result.files.isNotEmpty) {
                            controller.setProfileImagePath(
                                File(result.files.single.path ?? ''));
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: primaryBlueColor,
                          radius: 18,
                          child:
                              Icon(Icons.edit, color: neutral01Color, size: 18),
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
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              controller.setIdentityCardFile(
                                  File(result.files.single.path!));
                            }
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: neutral02Color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: controller.identityCardFile.value != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      controller.identityCardFile.value!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(Icons.add_photo_alternate,
                                        size: 50, color: Colors.grey),
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
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (result != null) {
                              controller.setStudentCardFile(
                                  File(result.files.single.path!));
                            }
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: neutral02Color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: controller.studentCardFile.value != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      controller.studentCardFile.value!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(Icons.add_photo_alternate,
                                        size: 50, color: Colors.grey),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                        selectedOption: controller
                            .genderOptions[controller.selectedGender.value],
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
                      maxLines: 5,
                      controller: controller.addressController,
                      hintText: 'Enter address',
                    ),
                    const SizedBox(height: 16),
                    Text('Residence Address', style: boldText12),
                    const SizedBox(height: 8),
                    CustomTextField(
                      maxLines: 5,
                      controller: controller.residenceAddressController,
                      hintText: 'Enter residence address',
                    ),
                    const SizedBox(height: 16),
                    Text('Bio', style: boldText12),
                    const SizedBox(height: 8),
                    CustomTextField(
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
                              String? name = await UserPreferences().getName();

                              controller.updateGeneral(
                                GeneralRequest(
                                  name: name ?? "",
                                  linkedinProfile:
                                      controller.linkedInController.text,
                                  instagramProfile:
                                      controller.instagramController.text,
                                  gender: controller.selectedGender.value,
                                  photo:
                                      controller.profileImageFile.value?.path ??
                                          "",
                                  identityCard:
                                      controller.identityCardFile.value?.path ??
                                          '',
                                  placeOfBirth:
                                      controller.placeOfBirthController.text,
                                  dateOfBirth:
                                      controller.dateOfBirthController.text,
                                  firstExpertiseId:
                                      controller.selectedFirstExpertise.value,
                                  secondExpertiseId:
                                      controller.selectedSecondExpertise.value,
                                  permanentAddress:
                                      controller.addressController.text,
                                  residenceAddress: controller
                                      .residenceAddressController.text,
                                  bio: controller.bioController.text,
                                ),
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
                                customSnackbar("All data has been cleared");
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
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
