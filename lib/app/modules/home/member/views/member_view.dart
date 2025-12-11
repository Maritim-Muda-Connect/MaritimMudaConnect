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
                          child: Column(
                            children: [
                              Expanded(
                                child: CupertinoScrollbar(
                                  controller: controller.scrollController,
                                  child: ListView.builder(
                                    controller: controller.scrollController,
                                    itemCount:
                                        controller.filteredMemberList.length,
                                    itemBuilder: (context, index) {
                                      final memberList =
                                          controller.filteredMemberList[index];
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2.5),
                                        color: neutral01Color,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: ListTile(
                                            onTap: () {
                                              controller
                                                  .getEmail(memberList.email!);
                                              Get.to(
                                                () => MemberDetailView(
                                                  memberList: memberList,
                                                ),
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: const Duration(
                                                    milliseconds: 100),
                                              );
                                            },
                                            leading: CircleAvatar(
                                              foregroundImage: NetworkImage(
                                                  memberList.photoLink!),
                                              backgroundImage: const AssetImage(
                                                  'assets/images/default_photo.jpg'),
                                            ),
                                            title: Text(
                                              memberList.name ?? "",
                                              style: regulerText16,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                                provinceOptions[memberList
                                                    .provinceId
                                                    .toString()]!,
                                                style: extraLightText16
                                                    .copyWith(fontSize: 14)),
                                            trailing: Icon(Icons.chevron_right,
                                                color: primaryDarkBlueColor)),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              _buildPaginationControls(),
                              const SizedBox(height: 16),
                            ],
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
    );
  }

  Widget _buildPaginationControls() {
    return Obx(() {
      final currentPage = controller.currentPage.value;
      final totalPages = controller.totalPages.value;

      if (totalPages <= 1) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          children: [
            Text(
              'Page $currentPage of $totalPages',
              style: regulerText16,
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPaginationButton(
                    icon: Icons.chevron_left,
                    onPressed: currentPage > 1
                        ? () => controller.previousPage()
                        : null,
                  ),
                  const SizedBox(width: 8),
                  ..._buildPageNumbers(currentPage, totalPages),
                  const SizedBox(width: 8),
                  _buildPaginationButton(
                    icon: Icons.chevron_right,
                    onPressed: currentPage < totalPages
                        ? () => controller.nextPage()
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildPageNumbers(int currentPage, int totalPages) {
    List<Widget> pageButtons = [];
    int startPage = 1;
    int endPage = totalPages;

    if (totalPages > 5) {
      if (currentPage <= 3) {
        endPage = 5;
      } else if (currentPage >= totalPages - 2) {
        startPage = totalPages - 4;
      } else {
        startPage = currentPage - 2;
        endPage = currentPage + 2;
      }
    }

    if (startPage > 1) {
      pageButtons.add(
        _buildPageNumberButton(1, currentPage),
      );
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text('...', style: regulerText14),
        ),
      );
    }

    for (int i = startPage; i <= endPage; i++) {
      pageButtons.add(_buildPageNumberButton(i, currentPage));
      if (i < endPage) {
        pageButtons.add(const SizedBox(width: 4));
      }
    }

    if (endPage < totalPages) {
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text('...', style: regulerText14),
        ),
      );
      pageButtons.add(
        _buildPageNumberButton(totalPages, currentPage),
      );
    }

    return pageButtons;
  }

  Widget _buildPageNumberButton(int pageNumber, int currentPage) {
    final isActive = pageNumber == currentPage;
    return GestureDetector(
      onTap: () => controller.goToPage(pageNumber),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? primaryDarkBlueColor : neutral01Color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? primaryDarkBlueColor : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          pageNumber.toString(),
          style: TextStyle(
            color: isActive ? neutral01Color : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: onPressed != null ? primaryDarkBlueColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: onPressed != null ? neutral01Color : Colors.grey[600],
            size: 20,
          ),
        ),
      ),
    );
  }
}
