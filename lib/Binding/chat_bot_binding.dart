import 'package:get/get.dart';
import 'package:tech_talk/controllers/chat_controller.dart';

class ChatBotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatBotController>(() => ChatBotController());
  }
}
