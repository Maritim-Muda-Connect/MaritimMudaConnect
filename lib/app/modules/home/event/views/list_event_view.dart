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
    return CupertinoScrollbar(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 200),
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
          } else if (controller.eventsList.isEmpty) {
            return Text(
              'Data belum tersedia',
              style: extraLightText16,
            );
          } else {
            return SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: controller.filterEventList.map((events) {
                  final String startDate =
                      DateFormat('dd/MM/yyyy').format(events.startDate!);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailEventView(
                                    eventData: events,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ProgramCard(
                        image: events.posterLink,
                        date: startDate,
                        textTitle: events.name,
                        textSubTitle: "",
                        onShare: () {
                          Share.share(
                              "Check this out: \n${events.externalUrl ?? "Sorry, this event does not have a URL available!"}",
                              subject: "Event Url");
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }),
      ),
    );
  }
}
