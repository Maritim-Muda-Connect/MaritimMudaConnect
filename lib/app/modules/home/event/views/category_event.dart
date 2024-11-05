import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/modules/home/event/controllers/event_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../themes.dart';
import '../../../../data/models/event_data.dart';
import '../../../widget/program_card.dart';
import 'detail_event_view.dart';

class CategoryEvent extends GetView<EventController> {
  const CategoryEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
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
            // scrollDirection: Axis.vertical,
            itemCount: controller.sortedEventList.length,
            itemBuilder: (context, index) {
              final event = controller.sortedEventList[index];
              final String startDate =
                  DateFormat('dd/MM/yyyy').format(event.startDate!);

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailEventView(
                                eventData: event,
                              )));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: ProgramCard(
                    image:
                        "https://lh3.googleusercontent.com/9uRdrnXVbm8VHdRBA7iu0n5BLUBARZVtJw3-u25b7V2d8MEHVqEgfiuJqvTxg6ePAWuylzpRMhF403srp3ogy52--yUue2YcFsTa85N98jVm4V-xglUz8EuvFv0PTSRnyg=w3374",
                    date: startDate,
                    textTitle: event.name,
                    textSubTitle: "Kocak ga ada deskripsi nya wkwk",
                    onShare: () {
                      Share.share("Check this out: \n${event.externalUrl ?? "Sorry, this event does not have a URL available!"}" , subject: "Event Url");
                    },
                    // views: event.views,
                    // likes: event.likes,
                    // send: event.send,
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
