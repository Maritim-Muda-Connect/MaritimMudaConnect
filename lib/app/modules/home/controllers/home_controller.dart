import 'package:get/get.dart';

import '../../../data/models/response/general_response.dart';
import '../../../data/services/general_service.dart';
import '../../../data/utils/user_preference.dart';

class HomeController extends GetxController {
  final name = ''.obs;
  final serialNumber = ''.obs;
  final userPreferences = UserPreferences();


  var generalData = GeneralResponse().obs;
  var photoImage = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchGeneral();
    fetchHomeGeneral();
  }

  Future<void> loadUserData() async {
    name.value = (await userPreferences.getName())?.toString() ?? 'User';
    serialNumber.value =
        (await userPreferences.getSerialNumber())?.toString() ?? '0000';
  }

  Future<void> fetchGeneral() async {
    try {
      isLoading(true);
      var data = await GeneralService().fetchGeneral();
      generalData.value = data;

    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchHomeGeneral() async {
    try {
      isLoading(true);
      var data = await GeneralService().fetchGeneral();
      generalData.value = data;
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
