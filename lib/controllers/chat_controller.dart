import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotController extends ChangeNotifier {
  final ChatUser currentUser = ChatUser(id: '1', firstName: 'You');
  final ChatUser botUser = ChatUser(id: '2', firstName: 'Tech Assistant');

  List<ChatMessage> messages = [];
  bool isTyping = false;

  static const String _apiKey = 'AQ.Ab8RN6IiNvA_QcbKj-aGn1Hl6E4qmLxipUOuMiLwS9be8Jw4FA';

  late final GenerativeModel _model;
  late final ChatSession _chat;

  ChatBotController() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system('''
    You are TechTalk Assistant, an AI helper embedded in TeckTalk — 
    a social platform where developers and tech enthusiasts come together 
    to ask questions, share knowledge, and solve technical problems.

    Your responsibilities:
    - Help users debug code, explain errors, and suggest solutions
    - Answer questions about programming languages, frameworks, tools, and best practices
    - Guide users on how to use TeckTalk features (posting questions, tagging topics, etc.)
    - Encourage users to share their solutions with the community
    - Keep answers clear, structured, and beginner-friendly when needed

    Rules:
    - Stay focused on technical and app-related topics only
    - If asked about something unrelated (politics, personal topics, etc.), 
      politely redirect: "I'm here to help with technical questions on TechTalk 😊"
    - Support both Arabic and English — respond in the same language the user writes in
    - Use code blocks when sharing code snippets
    '''),
    );

    _chat = _model.startChat();
  }

  Future<void> onSend(ChatMessage message) async {
    messages = [message, ...messages];
    isTyping = true;
    notifyListeners();

    try {
      final response = await _chat.sendMessage(Content.text(message.text));
      final responseText = response.text;

      if (responseText != null && responseText.isNotEmpty) {
        messages = [
          ChatMessage(user: botUser, createdAt: DateTime.now(), text: responseText),
          ...messages,
        ];
      }
    } catch (e) {
      String errorText;
      if (e is UnsupportedUserLocation) {
        errorText =
            'Unable to access user location. Please enable location services and try again.';
      } else {
        errorText = 'Service is busy right now. Please try again in a few moments.';
      }
      messages = [
        ChatMessage(user: botUser, createdAt: DateTime.now(), text: errorText),
        ...messages,
      ];
    } finally {
      isTyping = false;
      notifyListeners();
    }
  }
}