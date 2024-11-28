import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maritimmuda_connect/themes.dart';

class HomeCard extends StatelessWidget {
  final String icon;
  final String title;
  VoidCallback? onTap;

  HomeCard({super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: neutral01Color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      regulerText16.copyWith(fontSize: 18, color: neutral04Color),
                ),
                Icon(
                  Icons.chevron_right,
                  color: neutral03Color,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
