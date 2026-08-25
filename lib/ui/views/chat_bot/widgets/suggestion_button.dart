import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

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
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: Appcolor.panel,
          border: Border.all(color: Appcolor.panelEdge),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Appcolor.white, fontSize: 13),
        ),
      ),
    );
  }
}