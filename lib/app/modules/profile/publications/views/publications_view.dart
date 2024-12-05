import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/request/publication_request.dart';
import 'package:maritimmuda_connect/app/modules/profile/publications/controllers/publications_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_dropdown.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_textfield.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_button.dart';
import 'package:maritimmuda_connect/app/modules/widget/profile_card.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../widget/custom_dialog.dart';
import '../../../widget/custom_snackbar.dart';

class PublicationsView extends GetView<PublicationsController> {
  const PublicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchPublications();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Add Publications', style: regulerText24),
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
                        Text('Title', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter title',
                          controller: controller.titleC,
                          validator: controller.validateTitle,
                          focusNode: controller.focusNodes[0],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[1]);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text('Author(s)', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter author',
                          controller: controller.authorC,
                          validator: controller.validateAuthors,
                          focusNode: controller.focusNodes[1],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[2]);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text('Publication Type', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => CustomDropdown(
                            options: controller.publicationOptions,
                            validator: controller.validatePublicationType,
                            hintText: 'Choose your publications type',
                            selectedOption:
                                controller.selectedPublicationType.value,
                            onSelected: (String? newType) {
                              controller.setPubType(newType);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Publisher', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter publisher',
                          controller: controller.publisherC,
                          validator: controller.validatePublisher,
                          focusNode: controller.focusNodes[2],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[3]);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text('City of Publisher', style: boldText12),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter City of Publisher',
                          controller: controller.cityC,
                          validator: controller.validateCity,
                          focusNode: controller.focusNodes[3],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(controller.focusNodes[4]);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text('Date of Publication', style: boldText12),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => controller.selectDate(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              validator: controller.validateDate,
                              controller: controller.dateC,
                              hintText: 'Select date of publication',
                              suffixIcon: Icon(Icons.calendar_today,
                                  color: primaryDarkBlueColor),
                              focusNode: controller.focusNodes[4],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Title Page', style: boldText12),
                        const SizedBox(height: 8),
                        Obx(
                          () => Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: neutral02Color,
                              border: Border.all(color: neutral04Color),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    onTap: () => controller.pickImage(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      height: 36,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: neutral03Color,
                                        border:
                                            Border.all(color: neutral02Color),
                                      ),
                                      child: Text('Choose File',
                                          style: regulerText12),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    controller.selectedFileName.value,
                                    style: regulerText12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ProfileButton(
                              color: primaryDarkBlueColor,
                              icon: Icon(Icons.save_outlined,
                                  color: neutral01Color),
                              text: 'Save',
                              onTap: () {
                                if (controller.validateForm()) {
                                  if (controller.isEdit.value) {
                                    controller.updatePublications(
                                        PublicationRequest(
                                          title: controller.titleC.text,
                                          authorName: controller.authorC.text,
                                          type: controller.getTypeValue(
                                              controller.selectedPublicationType
                                                  .value),
                                          publisher: controller.publisherC.text,
                                          city: controller.cityC.text,
                                          publishDate: controller.formatDate(
                                              controller.selectedDate.value ??
                                                  DateTime.now()),
                                        ),
                                        controller.idCard.value);
                                    controller.isEdit.value = false;
                                    controller.idCard.value = 0;
                                  } else {
                                    controller.createPublication(
                                      PublicationRequest(
                                        title: controller.titleC.text,
                                        authorName: controller.authorC.text,
                                        type: controller.getTypeValue(controller
                                            .selectedPublicationType.value),
                                        publisher: controller.publisherC.text,
                                        city: controller.cityC.text,
                                        publishDate: controller.formatDate(
                                            controller.selectedDate.value ??
                                                DateTime.now()),
                                      ),
                                    );
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
                                if (controller.checkField()) {
                                  if (SnackbarController.isSnackbarBeingShown ==
                                      false) {
                                    customSnackbar(
                                      "All field already empty",
                                      secondaryRedColor,
                                    );
                                  }
                                } else {
                                  showCustomDialog(
                                    content:
                                        'Are you sure want to clear all data entered?',
                                    onConfirm: () {
                                      controller.clearAll();
                                      controller.isEdit.value = false;
                                      Get.back();
                                      customSnackbar(
                                        'All data has been deleted successfully',
                                      );
                                    },
                                    onCancel: () {
                                      Get.back();
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => Column(
                            children:
                                controller.publicationData.map((activity) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ProfileCard(
                                  title: activity.title!,
                                  leftSubTitle: activity.authorName!,
                                  rightTitle: activity.publisher,
                                  startDate: activity.publishDate != null
                                      ? controller
                                          .formatDate(activity.publishDate!)
                                      : 'N/A',
                                  onTap1: () {
                                    controller.isEdit.value = true;
                                    controller.idCard.value = activity.id!;
                                    controller.patchField(activity);
                                    controller.scrollController.animateTo(
                                      0.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  onTap2: () {
                                    showCustomDialog(
                                      content:
                                          'Are you sure you want to delete this data?',
                                      onConfirm: () {
                                        controller.deletePublication(
                                            activity.id ?? 0);
                                        Navigator.of(context).pop();
                                      },
                                      onCancel: () {
                                        Get.back();
                                      },
                                    );
                                  },
                                  onTap3: () {},
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
