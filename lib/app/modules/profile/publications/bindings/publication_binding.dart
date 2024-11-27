import 'package:get/get.dart';

import '../controllers/publications_controller.dart';

class PublicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicationsController>(
      () => PublicationsController(),
    );
  }
}
