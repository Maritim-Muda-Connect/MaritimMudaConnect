import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            width: 18,
            height: 18,
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
            linkedin == ""
                ? "assets/icons/linkedin_disable.svg"
                : "assets/icons/linkedin.svg",
            width: 24,
            height: 24,
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
            instagram == ""
                ? "assets/icons/instagram_disable.svg"
                : "assets/icons/instagram.svg",
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}
