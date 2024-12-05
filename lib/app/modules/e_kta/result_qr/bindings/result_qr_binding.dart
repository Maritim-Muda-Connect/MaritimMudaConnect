import 'package:get/get.dart';

import '../controllers/result_qr_controller.dart';

class ResultQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultQrController>(
      () => ResultQrController(),
    );
  }
}
