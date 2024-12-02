import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/widget/searchbar_widget.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {

  const EventView( {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: neutral02Color,

        appBar: AppBar(
          scrolledUnderElevation: 0,
            backgroundColor: neutral02Color,
            title: Text(
              'Event List',
              style: boldText24,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Container()
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              color: primaryBlueColor,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SearchbarEventWidget(),
              ),
            ),

            Container(
              width: double.infinity,
              color: primaryDarkBlueColor,
              child: Container(
                decoration: BoxDecoration(
                  color: neutral02Color,
                ),
                child: GetBuilder<EventController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.transparent,
                          child: TabBar(
                            physics: const BouncingScrollPhysics(),
                            controller: controller.tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            dividerColor: Colors.transparent,
                            indicatorPadding: EdgeInsets.zero,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle:
                                semiBoldText11.copyWith(color: neutral01Color),
                            indicator: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                            ),
                            tabs: List.generate(
                              7,
                              (index) {
                                return Obx(
                                  () {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              controller.selectedIndex.value ==
                                                      index
                                                  ? primaryDarkBlueColor
                                                  : neutral01Color,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              width: 1.0,
                                              color: primaryDarkBlueColor)),
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
                        SizedBox(
                          height: Get.height - 100,
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
          ]),
        ));
  }
}
