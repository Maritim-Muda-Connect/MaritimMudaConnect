import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/product/controllers/product_controller.dart';
import 'package:maritimmuda_connect/app/modules/product/detail_product/views/detail_product_view.dart';
import 'package:maritimmuda_connect/app/modules/product/all_product/widget/product_list.dart';
import 'package:maritimmuda_connect/themes.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

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
              child: Text("Produk tidak tersedia", style: semiBoldText16),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchProducts();
            },
            color: primaryDarkBlueColor,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.filteredProductList.length,
              itemBuilder: (context, index) {
                var product = controller.filteredProductList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
                  child: CatalogListItem(
                    product: product,
                    onTap: () {
                      Get.to(
                        () => DetailProductView(
                          productData: product,
                        ),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 100),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
