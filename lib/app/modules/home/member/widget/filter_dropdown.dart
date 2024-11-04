import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/expertise.dart';
import 'package:maritimmuda_connect/app/data/utils/province.dart';
import 'package:maritimmuda_connect/app/modules/home/member/controllers/member_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

class FilterDrawer extends GetView<MemberController> {
  const FilterDrawer({Key? key}) : super(key: key);

  String getProvinceNameById(String id) {
    return provinceOptions[id] ?? 'Unknown Province';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))),
      child: Container(
        color: primaryBlueColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Filter",
                        style: regulerText24.copyWith(color: neutral04Color)),
                    TextButton(
                      onPressed: () {
                        controller.resetFilters();
                      },
                      child: Text("Reset",
                          style: regulerText16.copyWith(color: neutral04Color)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Province Filter
                        FilterSection(
                          title: 'Province',
                          icon: Icons.maps_home_work,
                          items: provinceOptions.entries
                              .map((e) => MapEntry(e.key, e.value))
                              .toList(),
                          onSelected: (key) {
                            controller.setSelectedProvince(key);
                          },
                        ),
                        const SizedBox(height: 16),
                        // Expertise Filter
                        FilterSection(
                          title: 'Expertise',
                          icon: Icons.travel_explore_outlined,
                          items: expertiseOptions.entries
                              .map((e) => MapEntry(e.key, e.value))
                              .toList(),
                          onSelected: (key) {
                            controller.setSelectedExpertise(key);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterSection extends GetView<MemberController> {
  final String title;
  final IconData icon;
  final List<MapEntry<String, String>> items;
  final Function(String) onSelected;

  const FilterSection({
    Key? key,
    required this.title,
    required this.icon,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          icon: icon,
          items: items,
        ),
        SectionItems(
          title: title,
          items: items,
          onSelected: onSelected,
        ),
      ],
    );
  }
}

class SectionHeader extends GetView<MemberController> {
  final String title;
  final IconData icon;
  final List<MapEntry<String, String>> items;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.icon,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.toggleSection(title),
      child: Row(
        children: [
          Icon(icon, color: neutral04Color),
          const SizedBox(width: 10),
          Text(title, style: regulerText16.copyWith(color: neutral04Color)),
          const Spacer(),
          Obx(() {
            final selectedKey = controller.selectedItems[title];
            if (selectedKey != null) {
              return Expanded(
                child: Text(
                  items.firstWhere((item) => item.key == selectedKey).value,
                  style: regulerText14.copyWith(color: neutral04Color),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }
            return const SizedBox();
          }),
          const SizedBox(width: 4),
          Obx(() => Icon(
                controller.expandedSections[title] == true
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: neutral04Color,
              )),
        ],
      ),
    );
  }
}

class SectionItems extends GetView<MemberController> {
  final String title;
  final List<MapEntry<String, String>> items;
  final Function(String) onSelected;

  const SectionItems({
    Key? key,
    required this.title,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isExpanded = controller.expandedSections[title] ?? false;
      final selectedKey = controller.selectedItems[title];

      if (!isExpanded) return const SizedBox();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => InkWell(
                  onTap: () => onSelected(item.key),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.value,
                            style: (item.key == selectedKey
                                    ? boldText14
                                    : regulerText14)
                                .copyWith(color: neutral04Color),
                          ),
                        ),
                        if (item.key == selectedKey)
                          Icon(Icons.check, color: neutral04Color, size: 20),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );
    });
  }
}
