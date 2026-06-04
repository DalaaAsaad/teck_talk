import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/edit_profile/widgets/section_title.dart';

class BioInput extends StatefulWidget {
  const BioInput({
    required this.controller,
    required this.maxLength,
    required this.currentLength,
  });

  final TextEditingController controller;
  final int maxLength;
  final int currentLength;

  @override
  State<BioInput> createState() => _BioInputState();
}

class _BioInputState extends State<BioInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Bio', size: 20),
        TextField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          minLines: 4,
          maxLines: 4,
          style: TextStyle(color: Appcolor.white, fontSize: screenWidth(20)),
          decoration: _fieldDecoration().copyWith(counterText: ''),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: screenWidth(1.3)),
          child: Text(
            '${widget.currentLength}/${widget.maxLength}',
            style: TextStyle(
              color: Appcolor.yellow_70,
              fontSize: screenWidth(20),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _fieldDecoration() {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Appcolor.dark_20,
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth(40),
        vertical: screenWidth(40),
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
}
