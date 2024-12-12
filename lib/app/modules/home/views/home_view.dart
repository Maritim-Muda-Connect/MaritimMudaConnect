import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/modules/home/event/controllers/event_controller.dart';
import 'package:maritimmuda_connect/app/modules/home/event/views/detail_event_view.dart';
import 'package:maritimmuda_connect/app/modules/home/event/views/event_view.dart';
import 'package:maritimmuda_connect/app/modules/home/job/views/job_view.dart';
import 'package:maritimmuda_connect/app/modules/home/member/controllers/member_controller.dart';
import 'package:maritimmuda_connect/app/modules/home/scholarship/views/scholarship_view.dart';
import 'package:maritimmuda_connect/app/modules/home/widget/home_card.dart';
import 'package:maritimmuda_connect/app/modules/home/member/views/member_view.dart';
import 'package:maritimmuda_connect/app/modules/navbar/controllers/main_controller.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import '../controllers/home_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final EventController eventController = Get.find();

    return Scaffold(
      backgroundColor: neutral02Color,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset("assets/images/logo_maritim_muda_connect.png"),
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset("assets/images/logo_maritim.png"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    mainController.updateIndex(3);
                    mainController.pageController.jumpToPage(3);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: neutral01Color,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: neutral04Color.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello,",
                                style: regulerText16.copyWith(
                                    color: neutral04Color, fontSize: 20),
                              ),
                              Obx(
                                () => Text(
                                  controller.generalData.value.user?.name ?? '',
                                  style: semiBoldText24.copyWith(
                                      color: primaryBlueColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Obx(() => Text(
                                        "No: ${controller.serialNumber.value}",
                                        style:
                                            regulerText10.copyWith(fontSize: 9),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                (controller.generalData.value.user?.photoLink !=
                                            null &&
                                        controller.generalData.value.user!
                                            .photoLink!.isNotEmpty)
                                    ? NetworkImage(controller
                                        .generalData.value.user!.photoLink!)
                                    : const AssetImage(
                                        'assets/images/default_photo.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Obx(() {
            var latestEvents = eventController.eventsList
                .where((event) =>
                    event.posterLink != null && event.posterLink!.isNotEmpty)
                .toList();

            latestEvents.sort((a, b) => (b.createdAt ?? DateTime.now())
                .compareTo(a.createdAt ?? DateTime.now()));

            latestEvents = latestEvents.take(5).toList();

            if (eventController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (latestEvents.isEmpty) {
              return const Center(
                child: Text('No events available'),
              );
            }

            return CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: latestEvents.map((event) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: 320,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => DetailEventView(
                                eventData: event,
                              ));
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Image.network(
                            event.posterLink ??
                                'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'assets/images/placeholder.png');
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Wrap(
              spacing: 16,
              runSpacing: 24,
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  child: HomeCard(
                    icon: 'assets/icons/member_icon.svg',
                    title: 'Member',
                    onTap: () {
                      Get.find<MemberController>().searchQuery("");
                      Get.find<MemberController>().applyFilters();
                      Get.find<MemberController>().isFabVisible(false);
                      Get.to(() => const MemberView());
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  child: HomeCard(
                    icon: 'assets/icons/event_icon.svg',
                    title: 'Event',
                    onTap: () async {
                      String? uid = await UserPreferences().getUid();
                      if (uid == null || uid.isEmpty) {
                        if (SnackbarController.isSnackbarBeingShown == false) {
                          customSnackbar("This account doesn't have E-KTA",
                              secondaryRedColor);
                        }
                      } else {
                        Get.to(
                          () => const EventView(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 100),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  child: HomeCard(
                    icon: 'assets/icons/scholarship_icon.svg',
                    title: 'Scholarship',
                    onTap: () async {
                      String? uid = await UserPreferences().getUid();
                      if (uid == null || uid.isEmpty) {
                        if (SnackbarController.isSnackbarBeingShown == false) {
                          customSnackbar("This account doesn't have E-KTA",
                              secondaryRedColor);
                        }
                      } else {
                        Get.to(
                          () => const ScholarshipView(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 100),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 24,
                  child: HomeCard(
                    icon: 'assets/icons/job_icon.svg',
                    title: 'Jobs',
                    onTap: () async {
                      String? uid = await UserPreferences().getUid();
                      if (uid == null || uid.isEmpty) {
                        if (SnackbarController.isSnackbarBeingShown == false) {
                          customSnackbar("This account doesn't have E-KTA",
                              secondaryRedColor);
                        }
                      } else {
                        Get.to(
                          () => const JobView(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 100),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
