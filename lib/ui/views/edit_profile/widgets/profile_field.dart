import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/edit_profile/widgets/section_title.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: label, size: 20),
        SizedBox(height: screenWidth(60)),
        TextField(
          controller: controller,
          style: TextStyle(color: Appcolor.white, fontSize: screenWidth(20)),
          decoration: _fieldDecoration(),
        ),
      ],
    );
  }
}

InputDecoration _fieldDecoration() {
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: Appcolor.dark_20,
    contentPadding: EdgeInsets.symmetric(
      horizontal: screenWidth(25),
      vertical: screenWidth(60),
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
