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
      backgroundColor: neutral01Color,
      width: MediaQuery.of(context).size.width > 600
          ? MediaQuery.of(context).size.width / 3
          : MediaQuery.of(context).size.width / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Text(
              'Profile',
              style: semiBoldText28,
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: controller.drawerLists.map((drawer) {
                return _buildDrawerItem(
                  text: drawer["title"],
                  index: controller.drawerLists.indexOf(drawer),
                  controller: controller,
                  icon: drawer['icon'],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                showCustomDialog(
                  content: "Are you sure want to logout?",
                  onConfirm: () async {
                    await UserPreferences().logout();
                    Get.offAll(
                      () => const LoginView(),
                      binding: LoginBinding(),
                      transition: Transition.leftToRight,
                      duration: const Duration(milliseconds: 100),
                    );
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                    color: secondaryRedColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: neutral02Color,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Logout',
                      style: boldText16.copyWith(color: neutral02Color),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: neutral04Color,
                  height: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ),
              Text("version 1.0"),
              Expanded(
                child: Divider(
                  color: neutral04Color,
                  height: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String text,
    required int index,
    required MainDrawerController controller,
    IconData? icon,
  }) {
    return Obx(
      () => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          controller.onItemTapped(index);
          Get.back();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: controller.selectedIndex == index
                ? primaryDarkBlueColor.withOpacity(0.2)
                : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(icon,
                    color: controller.selectedIndex == index
                        ? primaryDarkBlueColor
                        : neutral04Color.withOpacity(0.5)),
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: controller.selectedIndex == index
                    ? boldText16.copyWith(
                        color: controller.selectedIndex == index
                            ? primaryDarkBlueColor
                            : neutral04Color)
                    : regulerText16.copyWith(
                        color: controller.selectedIndex == index
                            ? primaryDarkBlueColor
                            : neutral04Color.withOpacity(0.5),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
