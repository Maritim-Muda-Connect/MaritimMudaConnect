import 'package:get/get.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';
import 'package:maritimmuda_connect/app/modules/auth/login/bindings/login_binding.dart';
import 'package:maritimmuda_connect/app/modules/auth/login/views/login_view.dart';
import 'package:maritimmuda_connect/app/modules/navbar/bindings/main_binding.dart';
import 'package:maritimmuda_connect/app/modules/navbar/views/main_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    String? token = await UserPreferences().getToken();
    if (token == null) {
      Get.offAll(
        () => const LoginView(),
        binding: LoginBinding(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    } else {
      Get.offAll(
        () => MainView(),
        binding: MainBinding(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 100),
      );
    }
  }
}
