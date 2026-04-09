import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

import 'appcolor.dart';

class AppSnackBar {
  static void success(String message, {String title = 'Success'}) {
    _show(
      title: title,
      message: message,
      accentColor: Appcolor.yellow_70,
      icon: Icons.check_circle_rounded,
    );
  }

  static void error(String message, {String title = 'Error'}) {
    _show(
      title: title,
      message: message,
      accentColor: Appcolor.red,
      icon: Icons.error_rounded,
    );
  }

  static void _show({
    required String title,
    required String message,
    required Color accentColor,
    required IconData icon,
  }) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      '',
      '',
      titleText: Row(
        children: [
          Container(
            width: screenWidth(11),
            height: screenWidth(11),
            decoration: BoxDecoration(
              color: accentColor.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: screenWidth(20)),
          ),
          SizedBox(width: screenWidth(34)),
          Expanded(
            child: CustomText(
              text: title,
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(20),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      messageText: Padding(
        padding: EdgeInsetsDirectional.only(top: screenWidth(68.5)),
        child: Expanded(
          child: CustomText(
            text: message,
            styleType: TextStyleType.CUSTOM,
            fontSize: screenWidth(25),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Appcolor.gray_60.withAlpha(200),
      borderRadius: 18,
      margin: EdgeInsets.all(screenWidth(25)),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(25),
        vertical: screenWidth(25),
      ),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      borderColor: accentColor,
      borderWidth: 2,
      boxShadows: [
        BoxShadow(
          color: Appcolor.black_08.withAlpha(200),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}
