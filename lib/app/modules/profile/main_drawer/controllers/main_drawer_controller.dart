import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/profile/achievement/controllers/achievement_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/achievement/views/achievement_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/educations/views/educations_view.dart';
import 'package:maritimmuda_connect/app/modules/home/controllers/home_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/profile_user/controllers/profile_user_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/profile_user/views/profile_user_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/publication/controllers/publication_controller.dart';
import 'package:maritimmuda_connect/app/modules/profile/publication/views/publication_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/organizations/views/organizations_view.dart';
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

class MainDrawerController extends GetxController {
  var selectedIndex = 0.obs;
  var currentTitle = 'General'.obs;

  MainDrawerController() {
    currentTitle.value = title[selectedIndex.value];

    Get.put(ProfileUserController());
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(EducationsController());
    Get.put(WorkExperiencesController());
    Get.put(OrganizationsController());
    Get.put(AchievementController());
    Get.put(PublicationController());
    Get.put(SocialActivityController());
    Get.put(ResearchesController());
  }

  List<Widget> screens = [
    // Taruh halaman contoh const ProfileView() di sini
    const ProfileUserView(),
    const ProfileView(),
    const EducationsView(),
    const WorkExperiencesView(),
    const OrganizationsView(),
    const AchievementView(),
    const PublicationView(),
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

  // Kalo mau pake icon dari flutter nya
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

  // Kalo mau pake icon SVG dari figma, uncomment code di bawah ini
  // List<Widget> svgIcons = [
  //   SvgPicture.asset('assets/icons/general.svg'),
  //   SvgPicture.asset('assets/icons/educations.svg'),
  //   SvgPicture.asset('assets/icons/work_experiences.svg'),
  //   SvgPicture.asset('assets/icons/organizations.svg'),
  //   SvgPicture.asset('assets/icons/achievements.svg'),
  //   SvgPicture.asset('assets/icons/publications.svg'),
  //   SvgPicture.asset('assets/icons/social_activities.svg'),
  //   SvgPicture.asset('assets/icons/researches.svg'),
  //   SvgPicture.asset('assets/icons/logout.svg'),
  // ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
    currentTitle.value = title[index];
  }
}
