import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../themes.dart';
import '../controllers/profile_user_controller.dart';

class ProfileUserView extends GetView<ProfileUserController> {
  const ProfileUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      //appBar: AppBar(scrolledUnderElevation: 0.0),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                width: 403,
                decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 135,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                              color: primaryDarkBlueColor,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/paternkartu.png"))),
                        ),
                        const SizedBox(height: 50),
                        Text(controller.name.value, style: semiBoldText24),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(controller.placeOfBirth.value, style: regulerText16),
                            SizedBox(
                                height: 20,
                                child: VerticalDivider(color: neutral04Color)),
                            Text(controller.createdAt.value, style: regulerText16),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 63, top: 5, right: 63, bottom: 20),
                          child: Text(
                            controller.bio.value,
                            style:
                            regulerText10.copyWith(color: neutral04Color),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 75,
                      left: 140,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                AssetImage("assets/images/profile.png"))),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 29),
              Container(
                margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: neutral01Color,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Information",
                      style: semiBoldText24.copyWith(color: neutral04Color),
                    ),
                    const SizedBox(height: 21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 20,
                              color: subTitleColor,
                            ),
                            const SizedBox(width: 7),
                            Text("Email",
                                style: regulerText12.copyWith(
                                    color: subTitleColor)),
                          ],
                        ),
                        Text(controller.email.value,
                            style:
                            regulerText12.copyWith(color: neutral04Color))
                      ],
                    ),
                    const SizedBox(height: 27),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 20,
                              color: subTitleColor,
                            ),
                            const SizedBox(width: 7),
                            Text("Joined",
                                style: regulerText12.copyWith(
                                    color: subTitleColor)),
                          ],
                        ),
                        Text(controller.createdAt.value,
                            style:
                            regulerText12.copyWith(color: neutral04Color))
                      ],
                    ),
                    const SizedBox(height: 27),
                    Divider(color: neutral04Color),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("First Expertise",
                            style:
                            mediumText16.copyWith(color: neutral04Color)),
                        Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            style: regulerText10.copyWith(color: subTitleColor))
                      ],
                    ),
                    const SizedBox(height: 7),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Second Expertise",
                            style:
                            mediumText16.copyWith(color: neutral04Color)),
                        Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            style: regulerText10.copyWith(color: subTitleColor))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
