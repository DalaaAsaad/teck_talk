import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// حقل نصي بستايل GlassInputField بس بيدعم عدة أسطر + عداد أحرف اختياري
/// (مستخدم لحقل الـ Bio).
class MultilineGlassField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final int minLines;

  const MultilineGlassField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLength = 160,
    this.minLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.045),
        vertical: Responsive.hp(0.014),
      ),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            minLines: minLines,
            maxLines: minLines,
            maxLength: maxLength,
            cursorColor: Appcolor.accent,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.037),
              height: 1.4,
            ),
            decoration: InputDecoration(
              counterText: '',
              isCollapsed: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Appcolor.muted,
                fontSize: Responsive.sp(0.037),
              ),
            ),
          ),
          SizedBox(height: Responsive.hp(0.006)),
          Align(
            alignment: Alignment.centerRight,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) => CustomText(
                text: '${value.text.length}/$maxLength',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.muted,
                fontSize: Responsive.sp(0.028),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
