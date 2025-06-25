import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
// import 'package:maritimmuda_connect/app/modules/widget/social_media.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../../../../data/models/response/member_response.dart';
import '../controllers/member_controller.dart';
import 'package:maritimmuda_connect/app/routes/app_pages.dart';

class MemberDetailView extends GetView<MemberController> {
  const MemberDetailView({super.key, required this.memberList});
  final Member memberList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: neutral02Color,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryDarkBlueColor,
        onPressed: () async {
          String? uid = await UserPreferences().getUid();
          if (uid == null || uid.isEmpty) {
            if (SnackbarController.isSnackbarBeingShown == false) {
              customSnackbar(
                  "Please login to start chatting", secondaryRedColor);
            }
            return;
          }
          Get.toNamed(
            Routes.CHAT,
            arguments: {
              'recipientId': memberList.id,
              'recipientName': memberList.name,
              'recipientPhoto': memberList.photoLink,
            },
          );
        },
        child: Icon(
          Icons.chat_bubble_outline,
          color: neutral01Color,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: neutral01Color,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
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
                              image:
                                  AssetImage("assets/images/paternkartu.png"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          "${memberList.name}",
                          style: semiBoldText24,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                provinceOptions[
                                    memberList.provinceId.toString()]!,
                                style: regulerText16,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: VerticalDivider(color: neutral04Color),
                            ),
                            Obx(() {
                              if (controller.dateOfBirth.value.isNotEmpty) {
                                return Text(
                                  controller.dateOfBirth.value,
                                  style: regulerText16,
                                );
                              } else {
                                return const Text("");
                              }
                            }),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () {
                            if (controller.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: primaryDarkBlueColor,
                                ),
                              );
                            } else if (controller.memberData.value.user ==
                                null) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (memberList.email != null &&
                                        memberList.email!.isNotEmpty)
                                      IconButton(
                                        onPressed: () => launchUrl(Uri.parse(
                                            'mailto:${memberList.email}')),
                                        icon: SvgPicture.asset(
                                          "assets/icons/gmail.svg",
                                          colorFilter: ColorFilter.mode(
                                            primaryDarkBlueColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        tooltip: 'Send email',
                                      ),
                                  ],
                                ),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (controller.memberData.value.user?.email
                                            ?.isNotEmpty ??
                                        false)
                                      IconButton(
                                        onPressed: () => launchUrl(Uri.parse(
                                            'mailto:${controller.memberData.value.user!.email}')),
                                        icon: SvgPicture.asset(
                                          "assets/icons/gmail.svg",
                                          colorFilter: ColorFilter.mode(
                                            primaryDarkBlueColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        tooltip: 'Send email',
                                      ),
                                    if (controller.memberData.value.user
                                            ?.linkedinProfile?.isNotEmpty ??
                                        false) ...[
                                      const SizedBox(width: 12),
                                      IconButton(
                                        onPressed: () => launchUrl(Uri.parse(
                                            controller.memberData.value.user!
                                                .linkedinProfile!)),
                                        icon: SvgPicture.asset(
                                          "assets/icons/linkedin.svg",
                                          colorFilter: ColorFilter.mode(
                                            primaryDarkBlueColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        tooltip: 'View LinkedIn profile',
                                      ),
                                    ],
                                    if (controller.memberData.value.user
                                            ?.instagramProfile?.isNotEmpty ??
                                        false) ...[
                                      const SizedBox(width: 12),
                                      IconButton(
                                        onPressed: () => launchUrl(Uri.parse(
                                            controller.memberData.value.user!
                                                .instagramProfile!)),
                                        icon: SvgPicture.asset(
                                          "assets/icons/instagram.svg",
                                          colorFilter: ColorFilter.mode(
                                            primaryDarkBlueColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        tooltip: 'View Instagram profile',
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 63, top: 5, right: 63, bottom: 20),
                          child: Text(
                            memberList.bio ?? "no bio yet",
                            style:
                                regulerText10.copyWith(color: neutral04Color),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 75,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  child: CircleAvatar(
                                    maxRadius: 180,
                                    foregroundImage:
                                        NetworkImage(memberList.photoLink!),
                                    backgroundImage: const AssetImage(
                                        'assets/images/default_photo.jpg'),
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              minRadius: 50,
                              foregroundImage: memberList.photoLink != null
                                  ? NetworkImage(memberList.photoLink!)
                                  : null,
                              backgroundImage: const AssetImage(
                                  'assets/images/default_photo.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 29),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: primaryDarkBlueColor),
                  );
                }
                return Container(
                  margin:
                      const EdgeInsets.only(left: 14, right: 14, bottom: 14),
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
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: subTitleColor,
                                size: 32,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: regulerText12.copyWith(
                                        color: subTitleColor),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "${memberList.email}",
                                    style: regulerText14.copyWith(
                                        color: neutral04Color),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: subTitleColor,
                                size: 32,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Joined",
                                    style: regulerText12.copyWith(
                                        color: subTitleColor),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    DateFormat('MMMM yyyy').format(controller
                                            .memberData
                                            .value
                                            .user
                                            ?.emailVerifiedAt ??
                                        DateTime.now()),
                                    style: regulerText14.copyWith(
                                        color: neutral04Color),
                                  )
                                ],
                              )
                            ],
                          )
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
                            expertiseOptions[
                                    memberList.firstExpertiseId.toString()] ??
                                "Not set",
                            style: regulerText10.copyWith(color: subTitleColor),
                          )
                        ],
                      ),
                      const SizedBox(height: 7),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Second Expertise",
                            style: mediumText16.copyWith(color: neutral04Color),
                          ),
                          Text(
                            expertiseOptions[
                                    memberList.secondExpertiseId.toString()] ??
                                "Not set",
                            style: regulerText10.copyWith(color: subTitleColor),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
