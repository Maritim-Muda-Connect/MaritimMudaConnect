import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/achievements/controllers/achievements_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/controllers/profile_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/educations/controllers/educations_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/organizations/controllers/organizations_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/publications/controllers/publications_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/researches/controllers/researches_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/social_activity/controllers/social_activity_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/work_experiences/controllers/work_experiences_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_drawer.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/main_drawer_controller.dart';

class MainDrawerView extends GetView<MainDrawerController> {
  const MainDrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final EducationsController educationsController =
        Get.find<EducationsController>();
    final WorkExperiencesController workExperiencesController =
        Get.find<WorkExperiencesController>();
    final OrganizationsController organizationsController =
        Get.find<OrganizationsController>();
    final AchievementsController achievementsController =
        Get.find<AchievementsController>();
    final PublicationsController publicationController =
        Get.find<PublicationsController>();
    final SocialActivityController socialActivityController =
        Get.find<SocialActivityController>();
    final ResearchesController researchesController =
        Get.find<ResearchesController>();

    final List<GetxController> controllers = [
      profileController,
      educationsController,
      workExperiencesController,
      organizationsController,
      achievementsController,
      publicationController,
      socialActivityController,
      researchesController,
    ];

    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          backgroundColor: neutral01Color,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: neutral02Color,
            title: Obx(() => Text(controller.currentTitle.value)),
          ),
          endDrawer: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: CustomDrawer(controller: controller),
          ),
          body: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.screens,
            ),
          ),
        ),
        Obx(() {
          final isLoading = controllers.any((ctrl) {
            final dynamic dynamicController = ctrl;
            return dynamicController.isLoading.value;
          });
          return isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.3),
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 32,
                    ),
                    decoration: BoxDecoration(
                      color: neutral01Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CircularProgressIndicator(
                      color: primaryDarkBlueColor,
                    ),
                  ),
                )
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}
