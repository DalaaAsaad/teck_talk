import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class ActiveIcon extends StatelessWidget {
  final IconData icon;
  final IconData iconIsActive;
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
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: Responsive.hp(0.01),
        bottom: Responsive.hp(0.01),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: function,
            child: Icon(
              isActive ? iconIsActive : icon,
              size: Responsive.sp(0.065),
              color: isActive ? color : Appcolor.white.withAlpha(150),
            ),
          ),
          SizedBox(width: Responsive.wp(0.01)),
          CustomText(
            text: numOfInteractors ?? "",
            styleType: TextStyleType.CUSTOM,
            fontSize: Responsive.sp(0.04),
            textColor: Appcolor.label,
          ),
        ],
      ),
    );
  }
}
