import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart'
    show screenWidth;

enum TextStyleType { TITLE, SUBTITLE, BODY, SMALL, CUSTOM }

class CustomText extends StatelessWidget {
  final String? text;
  final TextStyleType? styleType;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  const CustomText({
    super.key,
    this.text,
    this.styleType = TextStyleType.BODY,
    this.textColor = Appcolor.white,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text!, style: getStyle(Get.size));
  }

  TextStyle getStyle(Size size) {
    TextStyle result = TextStyle();
    switch (styleType) {
      case TextStyleType.TITLE:
        result = TextStyle(
          fontSize: Responsive.sp(0.04),
          fontWeight: fontWeight ?? FontWeight.bold,
          color: textColor,
        );
        break;
      case TextStyleType.SUBTITLE:
        result = TextStyle(
          fontSize: Responsive.sp(0.03),
          fontWeight: fontWeight ?? FontWeight.bold,
          color: textColor,
        );
        break;
      case TextStyleType.BODY:
        result = TextStyle(
          fontSize: Responsive.sp(0.04),
          fontWeight: fontWeight ?? FontWeight.w400,
          color: textColor,
        );
        break;
      case TextStyleType.SMALL:
        result = TextStyle(
          fontSize: Responsive.sp(0.03),
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor,
        );
        break;
      case TextStyleType.CUSTOM:
        result = TextStyle(
          fontSize: fontSize ?? Responsive.sp(0.03),
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor,
        );
        break;
      default:
        result = TextStyle(
          fontSize: Responsive.sp(0.02),
          fontWeight: FontWeight.normal,
          color: textColor,
        );
        break;
    }
    return result;
  }
}
