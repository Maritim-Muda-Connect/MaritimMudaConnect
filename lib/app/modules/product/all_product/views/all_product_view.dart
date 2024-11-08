import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/product/all_product/widget/product_card.dart';
import 'package:maritimmuda_connect/app/modules/product/controllers/product_controller.dart';
import 'package:maritimmuda_connect/app/modules/product/detail_product/views/detail_product_view.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/all_product_controller.dart';

class AllProductView extends GetView<AllProductController> {
  const AllProductView({super.key});
  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find<ProductController>();
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: CircularProgressIndicator(color: primaryDarkBlueColor),
            ),
          );
        } else if (controller.productList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Text("Produk belum tersedia", style: semiBoldText16),
            ),
          );
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              return CatalogCard(
                onTap: () {
                  Get.to(() =>  DetailProductView(productData: controller.productList[index],));
                },
                productList: controller.productList[index],
              );
            },
          );
        }
      },
    );
  }
}
