import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../../../data/services/home/chat_service.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatService>(() => ChatService());
    
    Get.lazyPut<ChatController>(
      () => ChatController(
        chatService: Get.find<ChatService>(),
        recipientId: Get.arguments['recipientId'],
      ),
    );
  }
}
