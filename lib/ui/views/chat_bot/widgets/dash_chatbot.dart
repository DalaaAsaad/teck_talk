import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/chat_controller.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/chat_bot/widgets/suggestion_button.dart';

class DashChatbot extends GetView<ChatBotController> {
  const DashChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = controller.messages.isEmpty;

    return Stack(
      children: [
        DashChat(
          currentUser: controller.currentUser,
          onSend: controller.onSend,
          messages: controller.messages,
          typingUsers: controller.isTyping ? [controller.botUser] : [],
          inputOptions: InputOptions(
            inputTextStyle: const TextStyle(color: Appcolor.white),
            inputDecoration: InputDecoration(
              labelStyle: const TextStyle(color: Appcolor.white),
              hintText: 'Ask a technical question...',
              hintStyle: const TextStyle(color: Appcolor.muted),
              filled: true,
              fillColor: Appcolor.panel,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Appcolor.panelEdge, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Appcolor.accent, width: 1.5),
              ),
            ),
            sendButtonBuilder: (onSend) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: onSend,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Appcolor.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Appcolor.white, size: 18),
                  ),
                ),
              );
            },
          ),
          messageOptions: MessageOptions(
            currentUserContainerColor: Appcolor.accent,
            currentUserTextColor: Appcolor.white,
            containerColor: Appcolor.panel,
            textColor: Appcolor.white,
            borderRadius: 18,
            messageDecorationBuilder:
                (
                  ChatMessage message,
                  ChatMessage? previousMessage,
                  ChatMessage? nextMessage,
                ) {
                  final bool isMe = message.user.id == controller.currentUser.id;
                  return BoxDecoration(
                    color: isMe ? Appcolor.accent : Appcolor.panel,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isMe ? 18 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 18),
                    ),
                    border: isMe
                        ? null
                        : Border.all(color: Appcolor.panelEdge, width: 1),
                  );
                },
          ),
        ),


        if (isEmpty)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 80, 
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Appcolor.accentDim,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Appcolor.accent,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Hi, how can I help you today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _suggestion('Debug my code'),
                        _suggestion('Explain this error'),
                        _suggestion('Best practices'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _suggestion(String title) {
    return SuggestionButton(
      title: title,
      onTap: () => controller.onSend(
        ChatMessage(
          user: controller.currentUser,
          createdAt: DateTime.now(),
          text: title,
        ),
      ),
    );
  }
}