import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/home/member/views/member_detail_view.dart';
import 'package:maritimmuda_connect/app/modules/home/member/widget/filter_dropdown.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_snackbar.dart';
import 'package:maritimmuda_connect/app/modules/widget/searchbar_widget.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../controllers/member_controller.dart';

class MemberView extends GetView<MemberController> {
  const MemberView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MemberController());

    return Scaffold(
      backgroundColor: neutral02Color,
      // endDrawer: SafeArea(child: FilterDrawer(controller.memberList)),
      endDrawer: const SafeArea(child: FilterDrawer()),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: neutral02Color,
        excludeHeaderSemantics: false,
        actions: const [Text('')],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Column(
                children: [
                  SearchbarWidget(),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryDarkBlueColor,
                          ),
                        ),
                      );
                    } else if (controller.memberList.isEmpty) {
                      return Text(
                        'Data belum tersedia',
                        style: extraLightText16,
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredMemberList.length,
                          itemBuilder: (context, index) {
                            final memberList =
                                controller.filteredMemberList[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 7.5),
                              color: neutral01Color,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: ListTile(
                                onTap: () {
                                  if (memberList.emailVerifiedAt != null) {
                                    Get.to(() => MemberDetailView(
                                        memberList: memberList));
                                  } else {
                                    customSnackbar(
                                        "User not verified", secondaryRedColor);
                                  }
                                },
                                leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/profile.png"),
                                ),
                                title: Text(
                                  memberList.name ?? "",
                                  style: regulerText24,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                    provinceOptions[
                                        memberList.provinceId.toString()]!,
                                    style: extraLightText16),
                                trailing: CircleAvatar(
                                    backgroundColor: primaryDarkBlueColor,
                                    maxRadius: 15,
                                    child: Icon(Icons.chevron_right,
                                        color: neutral01Color)),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
