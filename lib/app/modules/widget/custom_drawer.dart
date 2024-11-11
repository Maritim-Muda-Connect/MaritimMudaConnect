import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/modules/auth/login/bindings/login_binding.dart';
import 'package:maritimmuda_connect/app/modules/auth/login/views/login_view.dart';
import 'package:maritimmuda_connect/app/modules/profile/main_drawer/controllers/main_drawer_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_dialog.dart';
import 'package:maritimmuda_connect/themes.dart';

class CustomDrawer extends StatelessWidget {
  final MainDrawerController controller;

  const CustomDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Text(
              'Profile',
              style: mediumText28,
            ),
          ),
          SizedBox(
            height: 500,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: controller.title.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildDrawerItem(
                      icon: controller.icon[index],
                      text: controller.title[index],
                      index: index,
                      controller: controller,
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: InkWell(
              onTap: () {
                showCustomDialog(
                  content: "Are you sure want to logout?",
                  onConfirm: () async {
                    await UserPreferences().logout();
                    Get.offAll(
                      () => const LoginView(),
                      binding: LoginBinding(),
                    );
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: secondaryRedColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Logout',
                    style: regulerText24.copyWith(color: secondaryRedColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String text,
    required int index,
    required MainDrawerController controller,
    IconData? icon,
    // Widget? icon,
  }) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.onItemTapped(index);
          Get.back();
        },
        child: Container(
          color: controller.selectedIndex == index
              ? primaryDarkBlueColor.withOpacity(0.2)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Icon(icon,
                  color: controller.selectedIndex == index
                      ? primaryDarkBlueColor
                      : neutral04Color),
              const SizedBox(width: 8),
              Text(
                text,
                style: regulerText16.copyWith(
                    color: controller.selectedIndex == index
                        ? primaryDarkBlueColor
                        : neutral04Color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
