import 'package:flutter/material.dart';

import '../../../../themes.dart';

class CustomCardSlider extends StatelessWidget {
  final ImageProvider image;
  const CustomCardSlider({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'test',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: neutral02Color,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(fit: BoxFit.contain, image: image)),
      ),
    );
  }
}
