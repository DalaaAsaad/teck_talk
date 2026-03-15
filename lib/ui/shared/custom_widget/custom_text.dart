import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart' show screenWidth;


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
    return Text(
      text!,
      style: getStyle(Get.size),
    );
  }
  TextStyle getStyle(Size size){
    TextStyle result = TextStyle();
    switch(styleType){
      case TextStyleType.TITLE:
        result = TextStyle(
            fontSize: screenWidth(16),
            fontWeight: fontWeight ?? FontWeight.bold,
            color: textColor);
        break;
      case TextStyleType.SUBTITLE:
        result = TextStyle(
            fontSize: screenWidth(20),
            fontWeight: fontWeight ?? FontWeight.normal,
            color: textColor);
        break;
      case TextStyleType.BODY:
        result = TextStyle(
            fontSize: screenWidth(25),
            fontWeight: fontWeight ?? FontWeight.w100,
            color: textColor);
        break;
      case TextStyleType.SMALL:
        result = TextStyle(
            fontSize: screenWidth(30),
            fontWeight: fontWeight ?? FontWeight.w200,
            color: textColor);
        break;
        default:
        result = TextStyle(
            fontSize: screenWidth(20),
            fontWeight: FontWeight.normal,
            color: textColor);
        break;
    }
    return result;
  }
}
