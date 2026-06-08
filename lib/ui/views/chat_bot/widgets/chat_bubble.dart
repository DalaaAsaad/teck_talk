import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;

  const ChatBubble({
    super.key,
    required this.isUser,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.amber
              : const Color(0xff1d1d1d),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}