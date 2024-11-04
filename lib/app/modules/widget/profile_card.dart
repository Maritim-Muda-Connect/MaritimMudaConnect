import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maritimmuda_connect/themes.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    this.rightTitle,
    this.leftSubTitle,
    this.rightSubTitle,
    this.startDate,
    this.endDate,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
    this.imageUrl,
  });

  final String title;
  final String? rightTitle;
  final String? leftSubTitle;
  final String? rightSubTitle;
  final String? startDate;
  final String? endDate;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral02Color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          if (imageUrl != null && imageUrl!.isNotEmpty)
            Container(
              width: 120,
              height: 160,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: FileImage(File(imageUrl!)),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          // Content section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: boldText24,
                        ),
                      ),
                      if (rightTitle != null)
                        Text(
                          '($rightTitle)',
                          style: regulerText12,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        '$leftSubTitle ',
                        style: regulerText12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        rightSubTitle != null ? '| $rightSubTitle' : "",
                        style: regulerText12,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        '${startDate ?? ''} ',
                        style: semiBoldText12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        endDate != null ? '- $endDate' : "",
                        style: semiBoldText12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: onTap1,
                        child: SvgPicture.asset('assets/icons/edit.svg'),
                      ),
                      const SizedBox(width: 3),
                      InkWell(
                        onTap: onTap2,
                        child: SvgPicture.asset('assets/icons/trashcan.svg'),
                      ),
                      FittedBox(
                        child: InkWell(
                          onTap: onTap3,
                          child: Icon(
                            Icons.menu,
                            color: primaryDarkBlueColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
