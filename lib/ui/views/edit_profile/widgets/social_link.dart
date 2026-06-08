import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class SocialLinkRow extends StatelessWidget {
  const SocialLinkRow({required this.assetPath, required this.controller});

  final String assetPath;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(40),
        vertical: screenWidth(40),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.dark_20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth(10),
            height: screenWidth(10),
            child: Image.asset(assetPath, fit: BoxFit.contain),
          ),
          SizedBox(width: screenWidth(40)),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Appcolor.white,
                fontSize: screenWidth(20),
              ),
              decoration: _fieldDecoration(),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration _fieldDecoration() {
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: Appcolor.dark_20,
    contentPadding: EdgeInsets.symmetric(
      horizontal: screenWidth(30),
      vertical: screenWidth(100),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Appcolor.gray_60),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Appcolor.yellow_70),
    ),
  );
}
