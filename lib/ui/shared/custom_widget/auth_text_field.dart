import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: screenWidth(20)),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: Appcolor.white, fontSize: screenWidth(29)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Appcolor.yellow_70,
            fontSize: screenWidth(29),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Appcolor.gray_60.withAlpha(150),
            fontSize: screenWidth(30),
          ),

          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Appcolor.yellow_70, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Appcolor.yellow_70, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Appcolor.yellow_70, width: 1),
          ),
          filled: true,
          fillColor: Appcolor.Black_05,
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: screenWidth(23),
            vertical: screenWidth(23),
          ),
        ),
      ),
    );
  }
}
