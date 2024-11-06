import 'package:get/get.dart';

import '../controllers/sub_product_controller.dart';

class SubProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubProductController>(
      () => SubProductController(),
    );
  }
}
