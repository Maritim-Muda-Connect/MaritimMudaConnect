import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/home/member/views/member_detail_view.dart';
import 'package:maritimmuda_connect/app/modules/widget/searchbar_widget.dart';
import 'package:maritimmuda_connect/app/routes/app_pages.dart';
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
                            controller: controller.scrollController,
                            child: ListView.builder(
                              controller: controller.scrollController,
                              itemCount: controller.filteredMemberList.length,
                              itemBuilder: (context, index) {
                                final memberList =
                                    controller.filteredMemberList[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 7.5),
                                  color: neutral01Color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      Get.to(
                                        () => MemberDetailView(
                                          memberList: memberList,
                                        ),
                                        transition: Transition.rightToLeft,
                                        duration: const Duration(milliseconds: 100),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            foregroundImage: memberList.photoLink != null
                                                ? NetworkImage(memberList.photoLink!)
                                                : null,
                                            backgroundImage: const AssetImage(
                                                'assets/images/default_photo.jpg'),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  memberList.name ?? "",
                                                  style: boldText16,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  provinceOptions[memberList.provinceId.toString()]!,
                                                  style: regulerText14.copyWith(color: neutral04Color),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Get.toNamed(
                                                    Routes.CHAT,
                                                    arguments: {
                                                      'recipientId': memberList.id,
                                                      'recipientName': memberList.name,
                                                      'recipientPhoto': memberList.photoLink,
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.chat_bubble_outline,
                                                  color: primaryDarkBlueColor,
                                                  size: 24,
                                                ),
                                                tooltip: 'Chat with ${memberList.name}',
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Get.to(
                                                    () => MemberDetailView(
                                                      memberList: memberList,
                                                    ),
                                                    transition: Transition.rightToLeft,
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: primaryDarkBlueColor,
                                                  size: 20,
                                                ),
                                                tooltip: 'View Profile',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
