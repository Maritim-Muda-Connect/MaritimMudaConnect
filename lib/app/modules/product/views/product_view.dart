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
    controller.scrollController.addListener(() {
      controller.isScrolled.value = controller.scrollController.offset > 0;
    });

    return Scaffold(
      backgroundColor: primaryDarkBlueColor,
      body: NestedScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: innerBoxIsScrolled ? 0 : 150,
              pinned: false,
              floating: false,
              backgroundColor: primaryBlueColor,
              flexibleSpace: innerBoxIsScrolled
                  ? null
                  : FlexibleSpaceBar(
                      background: _buildHeader(),
                    ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            color: neutral02Color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(37),
              topRight: Radius.circular(37),
            ),
          ),
          child: Column(
            children: [
              Obx(() {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: controller.isScrolled.value ? 50 : 0,
                      curve: Curves.easeInOut,
                    ),
                    const CustomSearch(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => DropdownButton<String>(
                                  value: controller.sortCriteria.value,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "id",
                                      child: Text("Default"),
                                    ),
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
                                        : const Icon(Icons.arrow_downward),
                                    onPressed: controller.toggleSortOrder,
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
                  ],
                );
              }),
              Expanded(
                child: Obx(() {
                  return controller.isCardView.value
                      ? const AllProductView()
                      : const CatalogList();
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 150,
      color: primaryBlueColor,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                "We Serve",
                style: regulerText15.copyWith(color: neutral01Color),
              ),
              Text(
                controller.productList.length.toString(),
                style: boldText32.copyWith(
                  color: neutral01Color,
                  fontSize: 42,
                ),
              ),
              Text(
                controller.productList.length > 1 ? "Product(s)" : "Product",
                style: regulerText15.copyWith(color: neutral01Color),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Transform.translate(
                        offset: const Offset(-20, 0),
                        child: Image.asset(
                          "assets/images/wave1.png",
                          width: 150,
                        ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Obx(
      () => controller.isFabVisible.value
          ? FloatingActionButton(
              onPressed: () {
                controller.scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: primaryDarkBlueColor,
              shape: const CircleBorder(),
              child: Icon(
                Icons.keyboard_double_arrow_up,
                color: neutral01Color,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
