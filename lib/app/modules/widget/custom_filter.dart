import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:maritimmuda_connect/app/modules/home/event/controllers/event_controller.dart';
import 'package:maritimmuda_connect/app/modules/home/scholarship/controllers/scholarship_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

class CustomFilter extends StatelessWidget {
  const CustomFilter({
    super.key,
    required this.filterText,
    required this.onTap,
  });

  final List<String>? filterText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: neutral01Color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: primaryDarkBlueColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Text("Urutkan Berdasarkan", style: mediumText12),
          ),
          Divider(color: neutral03Color, thickness: 1),
          Wrap(
            children: filterText!.map((text) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        text,
                        style:
                            regulerText12.copyWith(color: primaryDarkBlueColor),
                      ),
                    ),
                  ),
                  Divider(color: neutral03Color, thickness: 1),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}







class SortedEventFilter extends GetView<EventController> {
  const SortedEventFilter({
    super.key,
    required this.filterText,
    // required this.onFilterSelected,
  });

  final List<String> filterText;
  // final void Function(String) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 170,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryBlueColor, width: 1), // Blue outline
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Urutkan Berdasarkan",
                style: mediumText12.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(color: neutral03Color, thickness: 1),
            ...filterText.map((text) {
              return InkWell(
                onTap: () {
                  // onFilterSelected(text);
                  controller.updateFilter(text);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Text(
                    text,
                    style: regulerText12.copyWith(color: primaryDarkBlueColor),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );


  }
}


class SortedScholarFilter extends GetView<ScholarshipController> {
  const SortedScholarFilter({
    super.key,
    required this.filterText,
    // required this.onFilterSelected,
  });

  final List<String> filterText;
  // final void Function(String) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryBlueColor, width: 1), // Blue outline
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Urutkan Berdasarkan",
                style: mediumText12.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(color: neutral03Color, thickness: 1),
            ...filterText.map((text) {
              return InkWell(
                onTap: () {
                  // onFilterSelected(text);
                  controller.updateFilter(text);
                  // Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Text(
                    text,
                    style: regulerText12.copyWith(color: primaryDarkBlueColor),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );


  }
}
