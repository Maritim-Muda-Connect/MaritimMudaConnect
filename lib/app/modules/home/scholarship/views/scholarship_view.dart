import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/models/scholarship_data.dart';
import 'package:maritimmuda_connect/app/modules/widget/custom_filter.dart';
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
          backgroundColor: neutral02Color,
          title: Text(
            'Scholarship List',
            style: boldText24,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Container()
          ],
        ),
        body: Column(children: <Widget>[
          Container(
          color: primaryBlueColor,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: SearchbarScholarWidget()),
          ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
                // child:Expanded(

                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryDarkBlueColor,
                        ),
                      ),
                    );
                  } else if (controller.scholarshipList.isEmpty) {
                    return Text(
                      'Data belum tersedia',
                      style: extraLightText16,
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      itemCount: controller.filteredList.length,
                      itemBuilder: (context, index) {
                        final scholarship = controller.filteredList[index];
                        final String startDate = DateFormat('dd/MM/yyyy').format(scholarship.submissionDeadline!);
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScholarshipView(
                                          scholarshipData: scholarship,
                                        )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: ProgramCard(
                              image:
                              "https://lh3.googleusercontent.com/9uRdrnXVbm8VHdRBA7iu0n5BLUBARZVtJw3-u25b7V2d8MEHVqEgfiuJqvTxg6ePAWuylzpRMhF403srp3ogy52--yUue2YcFsTa85N98jVm4V-xglUz8EuvFv0PTSRnyg=w3374",
                              date: startDate,
                              textTitle: scholarship.name,
                              textSubTitle: scholarship.providerName,
                              onShare: () {
                                Share.share("Check this out: \n${scholarship.registrationLink ?? "Sorry, this scholarship does not have a URL available!"}" , subject: "Scholarship Url");
                              },
                              // views: scholarship.views,
                              // likes: scholarship.likes,
                              // send: scholarship.send,
                            ),
                          ),
                        );
                      },
                    );

                }
                })
            )
        )
        ]
        )
    );
  }
}
