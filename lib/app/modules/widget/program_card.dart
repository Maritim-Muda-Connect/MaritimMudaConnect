import 'package:flutter/material.dart';

import '../../../themes.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({
    super.key,
    this.image,
    this.date,
    this.textTitle,
    this.textSubTitle,
    this.onShare,
    // this.views,
    // this.likes,
    // this.send,
  });

  final String? image;
  final String? date;
  final String? textTitle;
  final String? textSubTitle;
  final VoidCallback? onShare;
  // final String? views;
  // final String? likes;
  // final String? send;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Get.to(() => MemberView());
      // },
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 1,
        child: Container(
          width: 378,
          decoration: BoxDecoration(
              color: neutral01Color,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: primaryBlueColor, width: 2.0)),
          padding:
              const EdgeInsets.only(left: 23, top: 19, right: 23, bottom: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(image!), fit: BoxFit.cover)),
              ),
              const SizedBox(height: 10),
              Text(textTitle!, style: boldText12),
              const SizedBox(height: 5),
              Opacity(
                opacity: 0.76,
                child: Text(
                  textSubTitle!,
                  style: regulerText8.copyWith(color: neutral04Color),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: primaryDarkBlueColor),
                      const SizedBox(width: 4),
                      Text(
                        date!,
                        style: regulerText10,
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.remove_red_eye_sharp,
                  //         color: primaryDarkBlueColor),
                  //     const SizedBox(width: 4),
                  //     Text(
                  //       views!,
                  //       style: regulerText10,
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.favorite, color: primaryDarkBlueColor),
                  //     const SizedBox(width: 4),
                  //     Text(
                  //       likes!,
                  //       style: regulerText10,
                  //     )
                  //   ],
                  // ),
                  IconButton(
                      icon: Icon(Icons.send, color: primaryDarkBlueColor),
                      onPressed: onShare,
                      // Text(
                      //   send!,
                      //   style: regulerText10,
                      // )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
