import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/achievements/views/achievements_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/educations/views/educations_view.dart';
import 'package:maritimmuda_connect/app/modules/home/controllers/home_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/profile_user/controllers/profile_user_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/profile_user/views/profile_user_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/organizations/views/organizations_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/publications/controllers/publications_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/publications/views/publications_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/views/profile_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/researches/controllers/researches_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/researches/views/researches_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/social_activity/controllers/social_activity_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/social_activity/views/social_activity_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/work_experiences/views/work_experiences_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/controllers/profile_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/educations/controllers/educations_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/work_experiences/controllers/work_experiences_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/organizations/controllers/organizations_controller.dart';

import '../../achievements/controllers/achievements_controller.dart';

class MainDrawerController extends GetxController {
  var selectedIndex = 0.obs;
  var currentTitle = 'General'.obs;
  List<Map<String, dynamic>> drawerLists;

  MainDrawerController() : drawerLists = [] {
    currentTitle.value = title[selectedIndex.value];

    Get.put(ProfileUserController());
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(EducationsController());
    Get.put(WorkExperiencesController());
    Get.put(OrganizationsController());
    Get.put(AchievementsController());
    Get.put(PublicationsController());
    Get.put(SocialActivityController());
    Get.put(ResearchesController());

    drawerLists = List.generate(
      title.length,
      (index) => {
        'title': title[index],
        'icon': icon[index]
      },
    );
  }

  List<Widget> screens = [
    const ProfileUserView(),
    const ProfileView(),
    const EducationsView(),
    const WorkExperiencesView(),
    const OrganizationsView(),
    const AchievementsView(),
    const PublicationsView(),
    const SocialActivityView(),
    const ResearchesView()
  ];

  List<String> title = [
    'Profile',
    'General',
    'Educations',
    'Work Experiences',
    'Organizations',
    'Achievements',
    'Publications',
    'Social Activities',
    'Researches',
  ];
  List<IconData> icon = [
    Icons.person_2_rounded,
    Icons.account_circle,
    Icons.school,
    Icons.work,
    Icons.group,
    Icons.emoji_events,
    Icons.menu_book,
    Icons.group_work,
    Icons.science,
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
    currentTitle.value = title[index];

    switch (index) {
      case 0:
        Get.find<ProfileUserController>().scrollController.jumpTo(0.0);
        break;
      case 1:
        Get.find<ProfileController>().scrollController.jumpTo(0.0);
        break;
      case 2:
        Get.find<EducationsController>().scrollController.jumpTo(0.0);
        break;
      case 3:
        Get.find<WorkExperiencesController>().scrollController.jumpTo(0.0);
        break;
      case 4:
        Get.find<OrganizationsController>().scrollController.jumpTo(0.0);
        break;
      case 5:
        Get.find<AchievementsController>().scrollController.jumpTo(0.0);
        break;
      case 6:
        Get.find<PublicationsController>().scrollController.jumpTo(0.0);
        break;
      case 7:
        Get.find<SocialActivityController>().scrollController.jumpTo(0.0);
        break;
      case 8:
        Get.find<ResearchesController>().scrollController.jumpTo(0.0);
        break;
      default:
        break;
    }
  }
}