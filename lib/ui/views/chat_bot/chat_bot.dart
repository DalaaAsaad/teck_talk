import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ChatUser currentUser = ChatUser(id: '1', firstName: 'You');
  final ChatUser botUser = ChatUser(id: '2', firstName: 'Tech Assistant');

  List<ChatMessage> messages = [];
  bool _isTyping = false;

  // 🔑 Paste your Gemini API key here
  static const String _apiKey =
      'AQ.Ab8RN6IiNvA_QcbKj-aGn1Hl6E4qmLxipUOuMiLwS9be8Jw4FA';

  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();

    // Initialize Gemini model (gemini-1.5-flash is free tier)
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
      politely redirect: "I'm here to help with technical questions on TeckTalk 😊"
    - Support both Arabic and English — respond in the same language the user writes in
    - Use code blocks when sharing code snippets
    '''),
    );

    // Start a persistent chat session (maintains history automatically)
    _chat = _model.startChat();

    messages.add(
      ChatMessage(
        user: botUser,
        createdAt: DateTime.now(),
        text: 'مرحباً 👋\nكيف يمكنني مساعدتك اليوم؟',
      ),
    );
  }

  Future<void> onSend(ChatMessage message) async {
    setState(() {
      messages.insert(0, message);
      _isTyping = true;
    });

    try {
      // Send message to Gemini — the ChatSession handles history
      final response = await _chat.sendMessage(Content.text(message.text));

      final responseText = response.text;

      if (responseText != null && responseText.isNotEmpty) {
        setState(() {
          messages.insert(
            0,
            ChatMessage(
              user: botUser,
              createdAt: DateTime.now(),
              text: responseText,
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        messages.insert(
          0,
          ChatMessage(
            user: botUser,
            createdAt: DateTime.now(),
            text: 'حدث خطأ:\n$e',
          ),
        );
      });
    } finally {
      setState(() => _isTyping = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black_08,
      appBar: AppBar(
        backgroundColor: Appcolor.black_08,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade600, width: 1),
                borderRadius: BorderRadius.circular(12),
                color: Appcolor.dark_20,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.grey.shade500,
                size: 25,
              ),
            ),
          ),
        ),
        title: CustomText(
          text: "Your tech AI assistant",
          styleType: TextStyleType.CUSTOM,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          textColor: Appcolor.white,
        ),
      ),
      body: DashChat(
        currentUser: currentUser,
        onSend: onSend,
        messages: messages,
        typingUsers: _isTyping ? [botUser] : [],
        inputOptions: InputOptions(
          inputTextStyle: const TextStyle(color: Colors.white),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            hintText: 'Ask a technical question...',
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: Appcolor.black_08,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Appcolor.yellow_70, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Appcolor.yellow_70, width: 2),
            ),
          ),
          sendButtonBuilder: (onSend) {
            return GestureDetector(
              onTap: onSend,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.send,
                  color: Appcolor.yellow_70,
                  size: 30,
                ),
              ),
            );
          },
        ),
        messageOptions: MessageOptions(
          currentUserContainerColor: Appcolor.yellow_70,
          currentUserTextColor: Colors.black,
          containerColor: Appcolor.black_08,
          textColor: Colors.white,
          borderRadius: 16,
          messageDecorationBuilder:
              (
                ChatMessage message,
                ChatMessage? previousMessage,
                ChatMessage? nextMessage,
              ) {
                final bool isMe = message.user.id == currentUser.id;
                return BoxDecoration(
                  color: isMe ? Appcolor.yellow_70 : Appcolor.black_08,
                  borderRadius: BorderRadius.circular(16),
                  border: isMe
                      ? null
                      : Border.all(color: Appcolor.yellow_70, width: 1.5),
                );
              },
        ),
      ),
    );
  }
}
