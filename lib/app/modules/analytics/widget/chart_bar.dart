import 'package:flutter/cupertino.dart';
import 'package:maritimmuda_connect/themes.dart';

class ChartBar extends StatelessWidget {
  final double height;
  final String value;
  final Color color;
  final String month;
  const ChartBar(
      {super.key,
      required this.value,
      required this.height,
      required this.color,
      required this.month});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: semiBoldText16.copyWith(color: neutral04Color),
        ),
        Container(
          width: 64,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(month, style: regulerText16.copyWith(color: neutral04Color),)
      ],
    );
  }
}
