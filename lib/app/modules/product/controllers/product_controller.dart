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
  var isCardView = true.obs;
  var sortCriteria = 'name'.obs;
  var isAscending = true.obs;

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

  void toggleSortOrder() {
    isAscending.value = !isAscending.value;
    applyFilters();
  }

  List<Product> sortProducts(List<Product> products) {
    var sortedList = List<Product>.from(products);
    switch (sortCriteria.value) {
      case 'name':
        sortedList.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case 'price':
        sortedList.sort((a, b) => int.parse(a.price!).compareTo(int.parse(b.price!)));
        break;
      case 'newest':
        sortedList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        break;
    }
    return isAscending.value ? sortedList : sortedList.reversed.toList();
}

  void toggleViewMode() {
    isCardView.value = !isCardView.value;
  }

  void setSortCriteria(String value) {
    sortCriteria.value = value;
    applyFilters();
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

    filterList = sortProducts(filterList);

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
