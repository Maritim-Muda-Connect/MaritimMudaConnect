import 'package:get/get.dart';
import '../controllers/chat_list_controller.dart';
import '../../../data/services/home/chat_service.dart';

class ChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatService>(() => ChatService());
    Get.lazyPut<ChatListController>(
      () => ChatListController(),
    );
  }
}