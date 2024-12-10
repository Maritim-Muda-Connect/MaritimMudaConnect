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
                  'Data belum tersedia',
                  style: extraLightText16,
                );
              } else {
                return RefreshIndicator(
                  color: primaryDarkBlueColor,
                  onRefresh: () async {
                    await controller.getAllScholarships();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.filteredList.length,
                      itemBuilder: (context, index) {
                        final scholarship = controller.filteredList[index];
                        final String startDate = DateFormat('dd/MM/yyyy')
                            .format(scholarship.submissionDeadline!);
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => DetailScholarshipView(
                                scholarshipData: scholarship,
                              ),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 100),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ProgramCard(
                              image: scholarship.posterLink,
                              date: startDate,
                              textTitle: scholarship.name,
                              textSubTitle: scholarship.providerName,
                              onShare: () {
                                Share.share(
                                    "Check this out: \n${scholarship.registrationLink ?? "Sorry, this scholarship does not have a URL available!"}",
                                    subject: "Scholarship Url");
                              },
                            ),
                          ),
                        );
                      },
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
