import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../themes.dart';
import '../../../widget/program_card.dart';
import '../../../widget/searchbar_widget.dart';
import '../controllers/scholarship_controller.dart';
import 'detail_scholarship_view.dart';

class ScholarshipView extends GetView<ScholarshipController> {
  const ScholarshipView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ScholarshipController());
    return Scaffold(
      backgroundColor: neutral02Color,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: neutral02Color,
        title: Text('Scholarship List', style: boldText24),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [Container()],
      ),
      body: Column(
        children: [
          Container(
            color: primaryBlueColor,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SearchbarScholarWidget(),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryDarkBlueColor,
                  ),
                );
              } else if (controller.scholarshipList.isEmpty) {
                return Text(
                  'No data available',
                  style: extraLightText16,
                );
              } else {
                return RefreshIndicator(
                  color: primaryDarkBlueColor,
                  onRefresh: () async {
                    await controller.getAllScholarships();
                  },
                  child: CupertinoScrollbar(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 4,
                          children: List.generate(
                            controller.filteredList.length,
                            (index) {
                              var scolarships = controller.filteredList[index];
                              final String startDate = DateFormat('dd/MM/yyyy')
                                  .format(scolarships.submissionDeadline!);

                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () => DetailScholarshipView(
                                        scholarshipData: scolarships),
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(milliseconds: 100),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ProgramCard(
                                    image: scolarships.posterLink,
                                    date: startDate,
                                    textTitle: scolarships.name,
                                    textSubTitle: "",
                                    onShare: () {
                                      Share.share(
                                          "Check this out: \n${scolarships.registrationLink ?? "Sorry, this event does not have a URL available!"}",
                                          subject: "Event Url");
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
