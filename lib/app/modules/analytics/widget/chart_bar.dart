import 'package:flutter/cupertino.dart';
import 'package:maritimmuda_connect/themes.dart';

class ChartBar extends StatelessWidget {
  final String value;
  final double height;
  final Color color;
  final String month;
  final bool isSelected;

  const ChartBar({
    super.key,
    required this.value,
    required this.height,
    required this.color,
    required this.month,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: regulerText12.copyWith(
            color: isSelected ? primaryBlueColor : neutral04Color,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 32,
          height: height,
          decoration: BoxDecoration(
            color: isSelected ? color : color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: regulerText12.copyWith(
            color: isSelected ? primaryBlueColor : neutral04Color,
          ),
        ),
      ],
    );
  }
}
