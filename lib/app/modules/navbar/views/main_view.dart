import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/modules/profile/achievements/controllers/achievements_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/controllers/profile_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/educations/controllers/educations_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/main_drawer/controllers/main_drawer_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/organizations/controllers/organizations_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/publications/controllers/publications_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/researches/controllers/researches_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/social_activity/controllers/social_activity_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/work_experiences/controllers/work_experiences_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_drawer.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../e_kta/views/e_kta_view.dart';
import '../controllers/main_controller.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final MainController controller = Get.put(MainController());
  final MainDrawerController controllerr = Get.put(MainDrawerController());

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

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Obx(
                () => controller.bottomNavIndex.value == 3
                    ? AppBar(
                        scrolledUnderElevation: 0.0,
                        backgroundColor: neutral02Color,
                        title: Text(controllerr.currentTitle.value),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            endDrawer: Obx(
              () => controller.bottomNavIndex.value == 3
                  ? CustomDrawer(controller: controllerr)
                  : const SizedBox.shrink(),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(32)),
              child: BottomAppBar(
                color: neutral01Color,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      controller.iconList.length + 1,
                      (index) {
                        if (index == 2) return const SizedBox(width: 40);

                        return GetBuilder<MainController>(
                          builder: (_) => _buildNavItem(
                            controller.iconList[index < 2 ? index : index - 1],
                            controller
                                .iconTitles[index < 2 ? index : index - 1],
                            index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.updateIndex(index);
                  },
                  physics: const ClampingScrollPhysics(),
                  children: controller.views,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                String? uid = await UserPreferences().getUid();
                if (uid == null || uid.isEmpty) {
                  customSnackbar(
                      "Akun ini belum memiliki E-KTA", secondaryRedColor);
                } else {
                  Get.to(
                    () => const EKtaView(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 100),
                  );
                }
              },
              backgroundColor: primaryDarkBlueColor,
              shape: const CircleBorder(),
              child: Icon(
                Icons.credit_card,
                color: neutral01Color,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
          Obx(
            () {
              final isLoading = controllers.any(
                (ctrl) {
                  final dynamic dynamicController = ctrl;
                  return dynamicController.isLoading.value;
                },
              );
              if (controller.bottomNavIndex.value != 0 && isLoading) {
                return Container(color: Colors.black.withOpacity(0.3));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Obx(
            () {
              final isLoading = controllers.any(
                (ctrl) {
                  final dynamic dynamicController = ctrl;
                  return dynamicController.isLoading.value;
                },
              );
              if (controller.bottomNavIndex.value != 0 && isLoading) {
                return Container(
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
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    int selectedIndex = controller.bottomNavIndex.value;
    Color iconColor = selectedIndex == (index < 2 ? index : index - 1)
        ? primaryDarkBlueColor
        : neutral03Color;

    return GestureDetector(
      onTap: () {
        controller.updateIndex(index < 2 ? index : index - 1);
        controller.pageController.animateToPage(
          controller.bottomNavIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: regulerText10.copyWith(color: iconColor),
          ),
        ],
      ),
    );
  }
}
