import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/catalog_controller.dart';

class CatalogView extends GetView<CatalogController> {
  const CatalogView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlueColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/images/wave2.png",
                      width: 60,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/images/red_line.png",
                      width: 70,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Work With",
                        style: regulerText15.copyWith(color: neutral01Color),
                      ),
                      Text(
                        "124",
                        style: boldText32.copyWith(
                            color: neutral01Color, fontSize: 42),
                      ),
                      Text(
                        "Partners",
                        style: regulerText15.copyWith(color: neutral01Color),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              "assets/images/wave1.png",
                              width: 150,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              "assets/images/wave3.png",
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
        body: Container(
          width: double.infinity,
          color: primaryDarkBlueColor,
          child: Container(
            decoration: BoxDecoration(
              color: neutral02Color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(37),
                topRight: Radius.circular(37),
              ),
            ),
            child: GetBuilder<CatalogController>(
              builder: (controller) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      color: Colors.transparent,
                      child: TabBar(
                        physics: const BouncingScrollPhysics(),
                        controller: controller.tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        indicatorPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: semiBoldText11.copyWith(
                          color: neutral01Color,
                        ),
                        indicator: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        tabs: List.generate(
                          5,
                          (index) {
                            return Obx(
                              () {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? primaryDarkBlueColor
                                            : neutral01Color,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Tab(
                                    text: controller.title[index],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: controller.screens,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
