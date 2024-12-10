import 'package:flutter/material.dart';
import 'package:maritimmuda_connect/themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.radius,
    this.width,
    this.height,
    this.textSize,
    this.gradient,
    this.isLoading,
    this.borderColor,
    this.textColor,
    this.shadowColor,
  });

  final String text;
  final void Function() onPressed;
  final Color? color;
  final double? radius;
  final double? width;
  final double? height;
  final TextStyle? textSize;
  final LinearGradient? gradient;
  final bool? isLoading;
  final Color? borderColor;
  final Color? textColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: shadowColor ?? null,
          padding: EdgeInsets.zero,
          backgroundColor: color ?? primaryBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
          elevation: 5,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 2
            ),
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
          child: Container(
            constraints:
                const BoxConstraints(minWidth: double.infinity, minHeight: 55),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: isLoading == true
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(color: neutral01Color),
                    )
                  : Text(
                      text,
                      style: textSize ??
                          boldText20.copyWith(color: textColor ?? neutral01Color),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
