import 'package:get/get.dart';

import '../controllers/achievements_controller.dart';

class AchievementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AchievementsController>(
      () => AchievementsController(),
    );
  }
}
