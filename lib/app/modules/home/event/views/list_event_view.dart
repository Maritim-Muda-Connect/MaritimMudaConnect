import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:maritimmuda_connect/app/modules/home/event/controllers/event_controller.dart';
import '../../../../../themes.dart';
import '../../../widget/program_card.dart';
import 'detail_event_view.dart';


class ListEventView extends GetView<EventController> {
  const ListEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: primaryDarkBlueColor,
                  ),
                ),
              );
            } else if (controller.eventsList.isEmpty) {
              return Text(
                'Data belum tersedia',
                style: extraLightText16,
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: controller.filterEventList.length,
                itemBuilder: (context, index) {
                  final event = controller.filterEventList[index];
                  final String startDate = DateFormat('dd/MM/yyyy').format(event.startDate!);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailEventView(
                                    eventData: event,
                                  )));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ProgramCard(
                        image:
                            event.posterLink,
                            // "https://lh3.googleusercontent.com/9uRdrnXVbm8VHdRBA7iu0n5BLUBARZVtJw3-u25b7V2d8MEHVqEgfiuJqvTxg6ePAWuylzpRMhF403srp3ogy52--yUue2YcFsTa85N98jVm4V-xglUz8EuvFv0PTSRnyg=w3374",
                        date: startDate ,
                        textTitle: event.name,
                        textSubTitle: "",
                        onShare: () {
                          Share.share("Check this out: \n${event.externalUrl ?? "Sorry, this event does not have a URL available!"}" , subject: "Event Url");
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }),


        );
  }
}