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
      controller: controller.scrollController,
      child: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? const EdgeInsets.fromLTRB(30, 0, 30, 170)
            : const EdgeInsets.fromLTRB(30, 0, 30, 195),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.event_busy,
                    color: Colors.grey,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Data belum tersedia, silahkan coba lagi nanti',
                    style: extraLightText16.copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: controller.scrollController,
              child: Wrap(
                spacing: 30,
                runSpacing: 4,
                children: List.generate(
                  controller.filterEventList.length,
                  (index) {
                    var events = controller.filterEventList[index];
                    final String startDate =
                        DateFormat('dd/MM/yyyy').format(events.startDate!);

                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => DetailEventView(eventData: events),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 100),
                        );
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
                  },
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
