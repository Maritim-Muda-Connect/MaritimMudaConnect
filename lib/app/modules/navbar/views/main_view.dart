import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../e_kta/views/e_kta_view.dart';
import '../controllers/main_controller.dart';

class MainView extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: BottomAppBar(
          color: neutral01Color,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(controller.iconList.length + 1, (index) {
                if (index == 2) return const SizedBox(width: 40);

                return GetBuilder<MainController>(
                  builder: (_) => _buildNavItem(
                    controller.iconList[index < 2 ? index : index - 1],
                    controller.iconTitles[index < 2 ? index : index - 1],
                    index,
                  ),
                );
              }),
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
            customSnackbar("Akun ini belum memiliki E-KTA", secondaryRedColor);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    int selectedIndex = controller.bottomNavIndex;

    Color iconColor = selectedIndex == (index < 2 ? index : index - 1)
        ? primaryDarkBlueColor
        : neutral03Color;

    return GestureDetector(
      onTap: () {
        controller.updateIndex(index < 2 ? index : index - 1);
        controller.pageController.animateToPage(
          controller.bottomNavIndex,
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
