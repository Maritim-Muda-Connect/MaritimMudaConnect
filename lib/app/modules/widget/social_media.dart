import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maritimmuda_connect/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    super.key,
    required this.gmail,
    required this.linkedin,
    required this.instagram,
  });

  final String gmail;
  final String linkedin;
  final String instagram;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            if (gmail != "") {
              await launchUrl(Uri.parse("mailto:$gmail"));
            }
          },
          child: SvgPicture.asset(
            "assets/icons/gmail.svg",
            color: gmail == "" ? subTitleColor : null,
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () async {
            if (linkedin != "") {
              await launchUrl(Uri.parse(linkedin));
            }
          },
          child: SvgPicture.asset(
            "assets/icons/linkedin.svg",
            color: linkedin == "" ? subTitleColor : null,
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
          onTap: () async {
            if (instagram != "") {
              await launchUrl(Uri.parse(instagram));
            }
          },
          child: SvgPicture.asset(
            "assets/icons/instagram.svg",
            color: instagram == "" ? subTitleColor : null,
          ),
        ),
      ],
    );
  }
}
