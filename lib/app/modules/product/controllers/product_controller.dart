import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/product_service.dart';
import 'package:maritimmuda_connect/app/modules/product/all_product/views/all_product_view.dart';
import 'package:maritimmuda_connect/app/modules/product/sub_product/views/sub_product_view.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var productList = <Product>[].obs;
  var filteredProductList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
      filterProductsByCategory(selectedIndex.value, title[selectedIndex.value]);
    });
  }

  List<String> title = ['All', 'Obat'];

  List<Widget> screens = [
    const AllProductView(),
    const SubProductView(),
  ];

  void filterProductsByCategory(int index, String value) {
    if (index == 0) {
      filteredProductList.assignAll(productList);
    } else if (index != 0) {
      filteredProductList.assignAll(
          productList.where((product) => product.category == value).toList());
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var data = await ProductService().fetchProducts();
      productList.assignAll(data.data ?? []);
      filterProductsByCategory(selectedIndex.value, title[selectedIndex.value]);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
