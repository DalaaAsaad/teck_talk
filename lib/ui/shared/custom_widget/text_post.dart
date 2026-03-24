import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';

class TextPost extends StatelessWidget {
  final String textPost;
  const TextPost({super.key, required this.textPost});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: CustomText(
        text: textPost,
        styleType: TextStyleType.BODY,
        textColor: Appcolor.white.withAlpha(200),
      ),
    );
  }
}
