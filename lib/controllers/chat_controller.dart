import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatController extends GetxController {
  final ChatUser currentUser =
      ChatUser(id: "1", firstName: "You");

  final ChatUser botUser =
      ChatUser(id: "2", firstName: "TechBot");

  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  final String apiKey = "YOUR_API_KEY";

  @override
  void onInit() {
    super.onInit();

    messages.add(
      ChatMessage(
        user: botUser,
        text:
            "👋 Hi there! I'm TechTalk AI, your coding companion.\nHow can I help you today?",
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> sendMessage(ChatMessage message) async {
    messages.insert(0, message);

    try {
      final response = await http.post(
        Uri.parse(
          "https://api.openai.com/v1/chat/completions",
        ),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "user",
              "content": message.text,
            }
          ]
        }),
      );

      final data = jsonDecode(response.body);

      final answer =
          data["choices"][0]["message"]["content"];

      messages.insert(
        0,
        ChatMessage(
          user: botUser,
          text: answer,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      messages.insert(
        0,
        ChatMessage(
          user: botUser,
          text: "Something went wrong.",
          createdAt: DateTime.now(),
        ),
      );
    }
  }
}