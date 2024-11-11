import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/educations_request.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_dropdown.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../widget/custom_dialog.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/profile_button.dart';
import '../controllers/educations_controller.dart';

class EducationsView extends GetView<EducationsController> {
  const EducationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchEducations();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: neutral02Color,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'Add Education History',
                  style: regulerText24,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 13),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextFieldSection(
                        title: 'Institution Name',
                        controller: controller.institutionController,
                        hintText: 'Enter your Institution Name',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter institution name'
                            : null,
                      ),
                      _buildTextFieldSection(
                        title: 'Major/Field of Study',
                        controller: controller.majorController,
                        hintText: 'Enter your Major/Field Study',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter major/field study name'
                            : null,
                      ),
                      _buildDropdownSection(),
                      _buildDatePickerSection(context),
                      const SizedBox(height: 16),
                      _buildActionButtons(),
                      const SizedBox(height: 30),
                      _buildEducationList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldSection({
    required String title,
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: boldText12),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          validator: validator,
          hintText: hintText,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Level', style: boldText12),
        const SizedBox(height: 8),
        Obx(
          () => CustomDropdown(
            hintText: 'Choose your education level',
            options: controller.levelOptions,
            selectedOption: controller.selectedLevel.value,
            onSelected: (String? newLevel) {
              controller.setLevel(newLevel);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDatePickerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Graduation Date', style: boldText12),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => controller.selectDate(context),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: controller.gradController,
              hintText: 'Select your graduation date',
              suffixIcon: Icon(Icons.calendar_today, color: primaryBlueColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfileButton(
          icon: Icon(Icons.save_outlined, color: neutral01Color),
          color: primaryDarkBlueColor,
          text: 'Save',
          onTap: () {
            if (controller.validateForm()) {
              EducationsRequest request = EducationsRequest(
                institutionName: controller.institutionController.text,
                major: controller.majorController.text,
                level: controller.getLevelValue(controller.selectedLevel.value),
                graduationDate: controller.formatDateRequest(
                  controller.selectedDate.value ?? DateTime.now(),
                ),
              );
              if (controller.isEdit.value) {
                controller.updateEducations(request, controller.idCard.value);
                controller.isEdit.value = false;
                controller.idCard.value = 0;
              } else {
                controller.createEducations(request);
              }
            }
          },
        ),
        const SizedBox(width: 10),
        ProfileButton(
          icon: Icon(Icons.close, color: neutral01Color),
          color: secondaryRedColor,
          text: 'Clear',
          onTap: () {
            controller.isEdit.value = false;
            showCustomDialog(
              content: 'Are you sure you want to clear all data entered?',
              onConfirm: () {
                controller.clearAll();
                Get.back();
                customSnackbar('All data has been deleted successfully');
              },
              onCancel: Get.back,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEducationList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(color: primaryDarkBlueColor),
          ),
        );
      } else if (controller.educationList.isEmpty) {
        return const SizedBox.shrink();
      } else {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.educationList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final activity = controller.educationList[index];
            return ProfileCard(
              title: activity.institutionName ?? 'N/A',
              leftSubTitle: activity.major ?? 'N/A',
              startDate: activity.graduationDate != null
                  ? controller.formatDate(activity.graduationDate)
                  : 'N/A',
              onTap1: () {
                controller.isEdit.value = true;
                controller.idCard.value = activity.id!;
                controller.patchField(activity);
              },
              onTap2: () {
                showCustomDialog(
                  content: 'Are you sure you want to delete this data?',
                  onConfirm: () {
                    controller.deleteEducations(activity.id ?? 0);
                    Get.back();
                  },
                  onCancel: Get.back,
                );
              },
              onTap3: () {},
            );
          },
        );
      }
    });
  }
}
