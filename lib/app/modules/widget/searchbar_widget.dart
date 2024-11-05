import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/home/member/controllers/member_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

import '../home/event/controllers/event_controller.dart';
import '../home/scholarship/controllers/scholarship_controller.dart';

class SearchbarWidget extends StatelessWidget {
  final controller = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => controller.searchMembers(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: neutral01Color,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: FilterSearchButton(),
        hintText: "Search member",
        hintStyle: regulerText15.copyWith(color: neutral03Color),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none),
      ),
    );
  }
}

class SearchbarEventWidget extends StatelessWidget {
  final controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => controller.searchEvents(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: neutral01Color,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: FilterSearchEventButton(),
        hintText: "Search event",
        hintStyle: regulerText15.copyWith(color: neutral03Color),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none),
      ),
    );
  }
}

class SearchbarScholarWidget extends StatelessWidget {
  final controller = Get.put(ScholarshipController());

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => controller.searchScholarship(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: neutral01Color,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: FilterSearchScholarButton(),
        hintText: "Search scholarship",
        hintStyle: regulerText15.copyWith(color: neutral03Color),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none),
      ),
    );
  }
}

class FilterSearchEventButton extends GetView<EventController> {


  @override
  Widget build(BuildContext context) {
    return Padding(
        // crossAxisAlignment: CrossAxisAlignment.start,

        padding: const EdgeInsets.all(8.0),
        child: (

          PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return controller.filterOptions.map((String filter) {
                  return PopupMenuItem(
                      value: filter,
                      child: filter == "Urutkan Berdasarkan:" ?
                      Text(filter, style: boldText14.copyWith(color: neutral04Color),):
                      Text(filter )
                  );

                }).toList();
              },
            color: Colors.white,

              onSelected: (selectedFilter) {
                controller.updateFilter(selectedFilter);
                },
              child: Container(
                decoration: BoxDecoration(
                  color: neutral01Color,
                  shape: BoxShape.circle,
                  border: Border.all(color: neutral02Color, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow

                    ),
                  ],
                ),
                child: Image.asset('assets/icons/filter_icon.png'),
              ),
            )

    ));
    }
}

class FilterSearchScholarButton extends GetView<ScholarshipController> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      // crossAxisAlignment: CrossAxisAlignment.start,

        padding: const EdgeInsets.all(8.0),
        child: (

            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return controller.filterOptions.map((String filter) {
                  return PopupMenuItem(
                      value: filter,
                      child: filter == "Urutkan Berdasarkan:" ?
                      Text(filter, style: boldText14.copyWith(color: neutral04Color),):
                      Text(filter )
                  );

                }).toList();
              },
              color: Colors.white,

              onSelected: (selectedFilter) {
                controller.updateFilter(selectedFilter);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: neutral01Color,
                  shape: BoxShape.circle,
                  border: Border.all(color: neutral02Color, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow

                    ),
                  ],
                ),
                child: Image.asset('assets/icons/filter_icon.png'),
              ),
            )

        ));
  }
}

class FilterSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: neutral01Color,
            shape: BoxShape.circle,
            border: Border.all(color: neutral02Color, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Image.asset('assets/icons/filter_icon.png'),
        ),
      ),
    );
  }
}
