import 'package:flutter/material.dart';
import 'package:maritimmuda_connect/themes.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
    this.validator,
    this.hintText,
  });

  final List<String> options;
  final String selectedOption;
  final Function(String?) onSelected;
  final String? hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral02Color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        validator: validator,
        value: selectedOption != '' && selectedOption != hintText ? selectedOption : null,
        onChanged: onSelected,
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            enabled: value != hintText,
            child: Text(
              value,
              style: regulerText12.copyWith(color: hintText == value ? neutral03Color : neutral04Color),
            ),
          );
        }).toList(),
        hint: hintText != null
            ? Text(
          hintText!,
          style: regulerText12.copyWith(color: neutral03Color),
        )
            : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: neutral03Color, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: neutral04Color, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: neutral04Color, width: 1),
          ),
        ),
        style: regulerText12.copyWith(color: neutral03Color),
        dropdownColor: neutral02Color,
        icon: Icon(Icons.arrow_drop_down, color: neutral03Color),
        isExpanded: true,
        menuMaxHeight: 200,
        selectedItemBuilder: (BuildContext context) {
          return options.map<Widget>((String item) {
            return Text(
              item,
              style: regulerText12.copyWith(color: neutral04Color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }).toList();
        },
      ),
    );
  }
}