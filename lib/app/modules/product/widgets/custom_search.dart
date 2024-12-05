import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/product/controllers/product_controller.dart';
import 'package:maritimmuda_connect/themes.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        onChanged: (value) => controller.searchProducts(value),
        decoration: InputDecoration(
          filled: true,
          fillColor: neutral01Color,
          prefixIcon: const Icon(Icons.search),
          hintText: "Search",
          hintStyle: regulerText15.copyWith(color: neutral03Color),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
