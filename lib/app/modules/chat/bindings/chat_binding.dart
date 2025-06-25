import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../../../data/services/home/chat_service.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ChatService>()) {
      Get.put(ChatService(), permanent: true);
    }

    final arguments = Get.arguments;

    if (arguments == null || arguments is! Map<String, dynamic>) {
      throw Exception('Invalid or missing arguments for ChatBinding');
    }

    final recipientId = arguments['recipientId'] as int?;

    if (recipientId == null) {
      throw Exception('RecipientId must be an integer');
    }

    Get.put(ChatController(
      chatService: Get.find<ChatService>(),
      recipientId: recipientId,
    ));
  }
}
