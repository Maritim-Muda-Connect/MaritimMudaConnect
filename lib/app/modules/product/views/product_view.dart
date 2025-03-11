import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/modules/product/all_product/views/all_product_view.dart';
import 'package:maritimmuda_connect/app/modules/product/all_product/views/all_product_list.dart';
import 'package:maritimmuda_connect/app/modules/product/widgets/custom_search.dart';
import 'package:maritimmuda_connect/themes.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: neutral02Color,
      child: SafeArea(
        top: false,
        child: Scaffold(
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
                                style: regulerText15.copyWith(
                                    color: neutral01Color),
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
                                style: regulerText15.copyWith(
                                    color: neutral01Color),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            Obx(() => controller.isFabVisible.value
                                ? const SizedBox(height: 60)
                                : const SizedBox.shrink()),
                            const CustomSearch(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Obx(
                                        () => DropdownButton<String>(
                                          value: controller.sortCriteria.value,
                                          items: const [
                                            DropdownMenuItem(
                                              value: "name",
                                              child: Text("Sort by Name"),
                                            ),
                                            DropdownMenuItem(
                                              value: "price",
                                              child: Text("Sort by Price"),
                                            ),
                                            DropdownMenuItem(
                                              value: "newest",
                                              child: Text("Sort by Newest"),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.setSortCriteria(value);
                                            }
                                          },
                                        ),
                                      ),
                                      Obx(() => IconButton(
                                            icon: controller.isAscending.value
                                                ? const Icon(Icons.arrow_upward)
                                                : const Icon(
                                                    Icons.arrow_downward),
                                            onPressed:
                                                controller.toggleSortOrder,
                                          )),
                                    ],
                                  ),
                                  Obx(() => IconButton(
                                        icon: controller.isCardView.value
                                            ? const Icon(Icons.view_list)
                                            : const Icon(Icons.view_module),
                                        onPressed: controller.toggleViewMode,
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Obx(() {
                                return controller.isCardView.value
                                    ? const AllProductView()
                                    : const CatalogList();
                              }),
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
                        bottom: MediaQuery.of(context).size.height * 0.04,
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
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                primaryDarkBlueColor),
                            shape:
                                WidgetStatePropertyAll<RoundedRectangleBorder>(
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
        ),
      ),
    );
  }
}
