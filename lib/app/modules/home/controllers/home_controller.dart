import 'package:get/get.dart';

import '../../../data/utils/user_preference.dart';

class HomeController extends GetxController {
  final name = ''.obs;
  final serialNumber = ''.obs;
  final userPreferences = UserPreferences();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    name.value = (await userPreferences.getName())?.toString() ?? 'User';
    serialNumber.value =
        (await userPreferences.getSerialNumber())?.toString() ?? '0000';
  }
}
