import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/models/response/product_response.dart';
import 'package:maritimmuda_connect/app/data/services/products/product_service.dart';
import 'package:maritimmuda_connect/app/modules/product/all_product/views/all_product_view.dart';
import 'package:maritimmuda_connect/app/modules/product/sub_product/views/sub_product_view.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final scrollController = ScrollController();

  var selectedIndex = 0.obs;
  var isLoading = false.obs;
  var productList = <Product>[].obs;
  var filteredProductList = <Product>[].obs;
  var searchQuery = ''.obs;
  var isFabVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    tabController = TabController(length: 1, vsync: this);
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
      filterProductsByCategory(selectedIndex.value, title[selectedIndex.value]);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels > 210) {
        isFabVisible(true);
      } else {
        isFabVisible(false);
      }
    });
  }

  List<String> title = ['All', 'Transport'];

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

  void searchProducts(String query) {
    searchQuery(query);
    applyFilters();
  }

  void applyFilters() {
    var filterList = List<Product>.from(productList);

    if (searchQuery.value.isNotEmpty) {
      filterList = filterList.where((products) {
        final nameMatch = products.name
                ?.toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ??
            false;
        return nameMatch;
      }).toList();
    }

    filteredProductList.assignAll(filterList);
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var data = await ProductService().fetchProducts();
      productList.assignAll(data.data ?? []);
      filterProductsByCategory(selectedIndex.value, title[selectedIndex.value]);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
