import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class AuthButton extends StatelessWidget {
  final String titleButton;
  final RxBool isLoading;
  final VoidCallback onTap;

  const AuthButton({
    super.key,
    required this.titleButton,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(
          vertical: screenWidth(10),
          horizontal: screenWidth(10),
        ),
        width: double.infinity,
        height: screenWidth(10),
        child: Material(
          color: Appcolor.yellow_70,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: isLoading.value ? null : onTap,
            child: Center(
              child: isLoading.value
                  ? SizedBox(
                      width: screenWidth(17),
                      height: screenWidth(17),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : CustomText(
                      text: titleButton,
                      styleType: TextStyleType.CUSTOM,
                      fontSize: screenWidth(25),
                      fontWeight: FontWeight.bold,
                      textColor: Appcolor.black_08,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
