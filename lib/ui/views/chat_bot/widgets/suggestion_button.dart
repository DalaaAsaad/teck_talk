import 'package:flutter/material.dart';

class SuggestionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SuggestionButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}