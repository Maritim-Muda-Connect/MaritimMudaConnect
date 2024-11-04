import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maritimmuda_connect/app/data/utils/user_preference.dart';

class ProfileUserController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final placeOfBirth = ''.obs;
  final bio = ''.obs;
  final createdAt = ''.obs;
  final userPreferences = UserPreferences();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    name.value = (await userPreferences.getName())?.toString() ?? 'User';
    email.value = (await userPreferences.getEmail())?.toString() ?? 'email@email.com';
    placeOfBirth.value = (await userPreferences.getPlaceOfBirth())?.toString() ?? 'Tempat Lahir';
    bio.value = (await userPreferences.getBio())?.toString() ?? 'No bio yet';
    createdAt.value = (await userPreferences.getCreatedAt()).toString();

    String? createdAtString = await userPreferences.getCreatedAt();
    if (createdAtString != null) {
      DateTime createdAtDate = DateTime.parse(createdAtString);
      createdAt.value = DateFormat("dd MMMM yyyy").format(createdAtDate);
    } else {
      createdAt.value = 'Tanggal tidak tersedia';
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
