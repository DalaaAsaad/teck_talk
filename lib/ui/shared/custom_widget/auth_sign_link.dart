import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class AuthSignLink extends StatelessWidget {
  final String questionText;
  final String linkText;
  final VoidCallback? onTap;
  const AuthSignLink({
    super.key,
    required this.questionText,
    required this.linkText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: screenWidth(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText(
            text: questionText,
            styleType: TextStyleType.BODY,
            textColor: Colors.grey[400],
          ),

          GestureDetector(
            onTap: onTap,
            child: CustomText(
              text: linkText,
              textColor: Appcolor.yellow_70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
