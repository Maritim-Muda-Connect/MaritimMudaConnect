import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/product/all_product/views/all_product_view.dart';
import 'package:maritimmuda_connect/app/modules/product/widgets/custom_search.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlueColor,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "assets/images/wave2.png",
                          width: 60,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            "We Serve",
                            style:
                                regulerText15.copyWith(color: neutral01Color),
                          ),
                          Text(
                            controller.productList.length.toString(),
                            style: boldText32.copyWith(
                                color: neutral01Color, fontSize: 42),
                          ),
                          Text(
                            controller.productList.length > 1
                                ? "Product(s)"
                                : "Product",
                            style:
                                regulerText15.copyWith(color: neutral01Color),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Image.asset(
                                  "assets/images/wave1.png",
                                  width: 150,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  "assets/images/wave3.png",
                                  width: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: Container(
              width: double.infinity,
              color: primaryDarkBlueColor,
              child: Container(
                decoration: BoxDecoration(
                  color: neutral02Color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(37),
                    topRight: Radius.circular(37),
                  ),
                ),
                child: GetBuilder<ProductController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        const CustomSearch(),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: const [
                              AllProductView(),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Obx(
            () => controller.isFabVisible.value
                ? Positioned(
                    right: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.height * 0.14,
                    child: IconButton(
                      onPressed: () {
                        controller.scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: Icon(
                        Icons.keyboard_double_arrow_up,
                        color: neutral01Color,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(primaryDarkBlueColor),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
