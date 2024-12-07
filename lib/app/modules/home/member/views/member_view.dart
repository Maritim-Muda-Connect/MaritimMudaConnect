import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/home/member/views/member_detail_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/searchbar_widget.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/member_controller.dart';

class MemberView extends GetView<MemberController> {
  const MemberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        title: Text(
          'Member List',
          style: boldText24,
        ),
        centerTitle: true,
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
                      return Expanded(
                        child: RefreshIndicator(
                          child: ListView(children: const [
                            Center(
                              child: Column(
                                children: [Text("No member found")],
                              ),
                            ),
                          ]),
                          onRefresh: () async {
                            await controller.getAllMember();
                          },
                        ),
                      );
                    } else {
                      return Expanded(
                        child: RefreshIndicator(
                          color: primaryDarkBlueColor,
                          onRefresh: () async {
                            await controller.getAllMember();
                          },
                          child: CupertinoScrollbar(
                            child: ListView.builder(
                              controller: controller.scrollController,
                              itemCount: controller.filteredMemberList.length,
                              itemBuilder: (context, index) {
                                final memberList =
                                    controller.filteredMemberList[index];
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 7.5),
                                  color: neutral01Color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: ListTile(
                                    onTap: () {
                                      controller.getEmail(memberList.email!);
                                      Get.to(
                                        () => MemberDetailView(
                                          memberList: memberList,
                                        ),
                                        transition: Transition.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 100),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      foregroundImage:
                                          NetworkImage(memberList.photoLink!),
                                      backgroundImage: const AssetImage(
                                          'assets/images/default_photo.jpg'),
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
                          ),
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
      floatingActionButton: Obx(
        () => controller.isFabVisible.value
            ? FloatingActionButton(
                backgroundColor: primaryDarkBlueColor,
                onPressed: () {
                  controller.scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(
                  Icons.keyboard_double_arrow_up_rounded,
                  color: neutral01Color,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
