import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/product/controllers/product_controller.dart';
import 'package:maritimmuda_connect/app/modules/product/detail_product/views/detail_product_view.dart';
import 'package:maritimmuda_connect/app/modules/product/sub_product/widget/list_product.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/sub_product_controller.dart';

class SubProductView extends GetView<SubProductController> {
  const SubProductView({super.key});
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
        } else if (controller.filteredProductList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Text("Produk belum tersedia", style: semiBoldText16),
            ),
          );
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.filteredProductList.length,
            itemBuilder: (context, index) {
              return ListCatalog(
                onTap: () {
                  Get.to(() => DetailProductView(productData: controller.filteredProductList[index],));
                },
                productList: controller.filteredProductList[index],
              );
            },
          );
        }
      },
    );
  }
}
