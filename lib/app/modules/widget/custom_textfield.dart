import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maritimmuda_connect/themes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    super.key,
    this.hintText,
    this.suffixIcon,
    this.preffixIcon,
    this.svgIcon,
    this.keyboardType,
    this.obscureText,
    this.validator,
    this.onChanged,
    this.maxLines,
    this.readOnly,
    this.inputAction,
  });

  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final String? svgIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool? readOnly;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      cursorHeight: 15,
      readOnly: readOnly ?? false,
      textInputAction: inputAction,
      style: regulerText12,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            readOnly == true ? neutral03Color.withOpacity(0.5) : neutral02Color,
        hintText: hintText,
        prefixIcon: svgIcon != null
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  svgIcon ?? "assets/icons/event_icon.svg",
                  color: neutral03Color,
                ),
              )
            : preffixIcon,
        suffixIcon: suffixIcon,
        isDense: true,
        hintStyle: TextStyle(
          fontSize: 11,
          color: neutral03Color,
          fontWeight: FontWeight.w500,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: secondaryRedColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryBlueColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: secondaryRedColor, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: neutral03Color, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: neutral03Color, width: 1.5),
        ),
      ),
    );
  }
}
