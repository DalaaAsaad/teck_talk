import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class ActiveIcon extends StatelessWidget {
  final Icon icon;
  final Icon iconIsActive;
  final Color color;
  final String? numOfInteractors;
  final bool isActive;
  final VoidCallback function;

  const ActiveIcon({
    super.key,
    required this.icon,
    required this.iconIsActive,
    required this.numOfInteractors,
    required this.color,
    required this.isActive,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: function,
          icon: isActive ? iconIsActive : icon,
          color: isActive ? color : Appcolor.white.withAlpha(150),
          iconSize: screenWidth(15),
        ),
        CustomText(
          text: numOfInteractors ?? "",
          styleType: TextStyleType.SMALL,
        ),
      ],
    );
  }
}
