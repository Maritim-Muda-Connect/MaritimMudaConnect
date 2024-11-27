import 'package:get/get.dart';

import '../controllers/profile_user_controller.dart';

class ProfileUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileUserController>(
      () => ProfileUserController(),
    );
  }
}
