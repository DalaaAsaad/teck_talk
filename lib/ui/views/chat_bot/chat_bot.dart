import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/chat_controller.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/chat_bot/widgets/dash_chatbot.dart';
import 'package:tech_talk/ui/views/chat_bot/widgets/title_chatbot.dart';

class ChatBot extends GetView<ChatBotController> {
  const ChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      appBar: AppBar(
        backgroundColor: Appcolor.bg,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const TitleChatbot(),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return DashChatbot();
        },
      ),
    );
  }
}
