import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maritimmuda_connect/themes.dart';

class MenuBarWidget extends StatefulWidget {
  final String menu;
  final bool isSelected;
  const MenuBarWidget({super.key, required this.menu, this.isSelected = false});

  @override
  _MenuBarWidgetState createState() => _MenuBarWidgetState();
}

class _MenuBarWidgetState extends State<MenuBarWidget> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? primaryDarkBlueColor : neutral01Color,
        ),
        child: Text(
          widget.menu,
          style: semiBoldText8.copyWith(
            color: isSelected ? neutral01Color : neutral04Color,
          ),
        ),
      ),
    );
  }
}
