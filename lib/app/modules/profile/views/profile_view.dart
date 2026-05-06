import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:maritimmuda_connect/app/modules/profile/widgets/avatar_general.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_dropdown.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/profile_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_button.dart';
import 'package:maritimmuda_connect/app/data/utils/countries.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_button.dart';
import 'package:maritimmuda_connect/app/data/models/request/general_request.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  void _showDeleteConfirmationDialog(BuildContext context) {
    controller.clearDeleteConfirm();
    Get.dialog(
      Dialog(
        backgroundColor: neutral01Color,
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
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                keyboardType: TextInputType.text,
                                controller: controller.nameController,
                                hintText: 'Enter your name',
                                onChanged: (value) {
                                  controller.nameError.value = '';
                                },
                              ),
                              if (controller.nameError.value.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    controller.nameError.value,
                                    style: TextStyle(
                                      color: secondaryRedColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
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
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDropdown(
                                hintText: 'Choose your gender',
                                options: controller.genderOptions,
                                selectedOption:
                                    controller.selectedGender.value >= 0 &&
                                            controller.selectedGender.value <
                                                controller.genderOptions.length
                                        ? controller.genderOptions[
                                            controller.selectedGender.value]
                                        : '',
                                onSelected: (String? value) {
                                  controller.setGender(value);
                                  controller.genderError.value = '';
                                },
                              ),
                              if (controller.genderError.value.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    controller.genderError.value,
                                    style: TextStyle(
                                      color: secondaryRedColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Provincial Organization', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: controller.provincialOrgController,
                          hintText: 'Province of your organization',
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
                                  color: primaryDarkBlueColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('LinkedIn', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: controller.linkedInController,
                          hintText: 'Enter your LinkedIn profile URL',
                        ),
                        const SizedBox(height: 16),
                        Text('Instagram', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: controller.instagramController,
                          hintText: 'Enter your Instagram profile',
                        ),
                        const SizedBox(height: 16),
                        Text('First Expertise', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDropdown(
                                hintText: 'Choose your first expertise',
                                options: firstExpertise,
                                selectedOption: controller
                                                .selectedFirstExpertise.value >=
                                            0 &&
                                        controller
                                                .selectedFirstExpertise.value <
                                            firstExpertise.length
                                    ? firstExpertise[
                                        controller.selectedFirstExpertise.value]
                                    : '',
                                onSelected: (String? value) {
                                  controller.setFirstExpertise(value);
                                  controller.firstExpertiseError.value = '';
                                },
                              ),
                              if (controller
                                  .firstExpertiseError.value.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    controller.firstExpertiseError.value,
                                    style: TextStyle(
                                      color: secondaryRedColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Second Expertise', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDropdown(
                                hintText: 'Choose your second expertise',
                                options: secondExpertise,
                                selectedOption:
                                    controller.selectedSecondExpertise.value >=
                                                0 &&
                                            controller.selectedSecondExpertise
                                                    .value <
                                                secondExpertise.length
                                        ? secondExpertise[controller
                                            .selectedSecondExpertise.value]
                                        : '',
                                onSelected: (String? value) {
                                  controller.setSecondExpertise(value);
                                },
                              ),
                              if (controller
                                  .secondExpertiseError.value.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    controller.secondExpertiseError.value,
                                    style: TextStyle(
                                      color: secondaryRedColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Citizenship', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => CustomDropdown(
                            hintText: 'Choose your citizenship',
                            options: countryOptions,
                            selectedOption:
                                controller.selectedCitizenship.value,
                            onSelected: (String? value) {
                              controller.setCitizenship(value);
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
                          hintText: 'Tell something about yourself',
                        ),
                        const SizedBox(height: 24),
                        Text('Identity Card', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DottedBorder(
                                dashPattern: const [10],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                padding: const EdgeInsets.all(6),
                                color: controller
                                        .identityCardError.value.isNotEmpty
                                    ? secondaryRedColor
                                    : neutral03Color,
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
                                      controller.identityCardError.value = '';
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
                                            child: controller
                                                        .photoIdentity.value
                                                        .contains("via") ||
                                                    controller
                                                        .photoIdentity.value
                                                        .contains("cloudinary")
                                                ? SizedBox(
                                                    width: double.infinity,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Input Identity Card",
                                                        style: semiBoldText12,
                                                      ),
                                                    ),
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
                                  ),
                                ),
                              ),
                              if (controller.identityCardError.value.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    controller.identityCardError.value,
                                    style: TextStyle(
                                      color: secondaryRedColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          "Maximum file size: 50KB",
                          style: boldText12.copyWith(
                              color: neutral03Color,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 16),
                        Text('Student Card / Business Card', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DottedBorder(
                                dashPattern: const [10],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                padding: const EdgeInsets.all(6),
                                color:
                                    controller.studentCardError.value.isNotEmpty
                                        ? secondaryRedColor
                                        : neutral03Color,
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
                                      controller.studentCardError.value = '';
                                    }
                                  },
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: neutral02Color,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: controller
                                            .paymentImagePath.value.isEmpty
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: controller.photoPayment.value
                                                        .contains("via") ||
                                                    controller
                                                        .photoPayment.value
                                                        .contains('cloudinary')
                                                ? SizedBox(
                                                    width: double.infinity,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Input Academic or Professional ID",
                                                        style: semiBoldText12,
                                                      ),
                                                    ),
                                                  )
                                                : Image.network(
                                                    controller
                                                        .photoPayment.value,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(
                                              File(controller
                                                  .paymentImagePath.value),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              if (controller.studentCardError.value.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    controller.studentCardError.value,
                                    style: TextStyle(
                                      color: secondaryRedColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          "Maximum file size: 200KB",
                          style: boldText12.copyWith(
                              color: neutral03Color,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 24),
                        ProfileButton(
                          icon:
                              Icon(Icons.save_outlined, color: neutral01Color),
                          text: 'Save',
                          color: primaryDarkBlueColor,
                          onTap: () {
                            if (controller.validateForm()) {
                              int firstExpertiseId =
                                  controller.getFirstExpertiseId(
                                controller.selectedFirstExpertise.value,
                              );

                              int secondExpertiseId =
                                  controller.getSecondExpertiseId(
                                controller.selectedSecondExpertise.value,
                              );

                              final request = GeneralRequest(
                                name: controller.nameController.text,
                                linkedinProfile:
                                    controller.linkedInController.text,
                                instagramProfile:
                                    controller.instagramController.text,
                                gender: controller.selectedGender.value,
                                placeOfBirth:
                                    controller.placeOfBirthController.text,
                                dateOfBirth:
                                    controller.dateOfBirthController.text,
                                firstExpertiseId: firstExpertiseId,
                                secondExpertiseId: secondExpertiseId,
                                permanentAddress:
                                    controller.addressController.text,
                                residenceAddress:
                                    controller.residenceAddressController.text,
                                bio: controller.bioController.text,
                                citizenship:
                                    controller.selectedCitizenship.value,
                              );

                              final photoFile =
                                  controller.photoImagePath.value.isNotEmpty
                                      ? File(controller.photoImagePath.value)
                                      : File('');

                              final identityFile =
                                  controller.identityImagePath.value.isNotEmpty
                                      ? File(controller.identityImagePath.value)
                                      : File('');

                              final paymentFile =
                                  controller.paymentImagePath.value.isNotEmpty
                                      ? File(controller.paymentImagePath.value)
                                      : File('');

                              controller.updateGeneral(
                                request,
                                photoFile,
                                identityFile,
                                paymentFile,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Divider(color: neutral02Color, thickness: 3),
                        const SizedBox(height: 16),
                        Text('Delete Account',
                            style:
                                boldText16.copyWith(color: secondaryRedColor)),
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
                            obscureText:
                                controller.isDeletePasswordHidden.value,
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
                          () => Align(
                            alignment: Alignment.centerLeft,
                            child: CustomButton(
                              text: "Request Account Deletion",
                              height: 35,
                              width: 220,
                              textSize:
                                  boldText12.copyWith(color: neutral01Color),
                              onPressed: controller.isDeletePasswordFilled.value
                                  ? () {
                                      controller.requestDeleteAccount(
                                        onSuccess: () =>
                                            _showDeleteConfirmationDialog(
                                                context),
                                      );
                                    }
                                  : null,
                              color: controller.isDeletePasswordFilled.value
                                  ? secondaryRedColor
                                  : neutral03Color,
                            ),
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
      ),
    );
  }
}
