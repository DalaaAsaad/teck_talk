import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class IconWithTitle extends StatelessWidget {
  final Callback onTap;
  final String svgPath;
  final String title;

  const IconWithTitle({
    super.key,
    required this.svgPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: SvgPicture.asset(svgPath, width: screenWidth(7)),
        ),
        SizedBox(height: screenWidth(50)),
        CustomText(text: title, styleType: TextStyleType.BODY),
      ],
    );
  }
}
