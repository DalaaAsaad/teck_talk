import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final bool isSaving;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.isSaving = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.037),
                fontWeight: FontWeight.w600,
              ),
              if (subtitle != null) ...[
                SizedBox(height: Responsive.hp(0.003)),
                CustomText(
                  text: subtitle!,
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.muted,
                  fontSize: Responsive.sp(0.03),
                ),
              ],
            ],
          ),
        ),
        if (isSaving)
          SizedBox(
            width: Responsive.wp(0.045),
            height: Responsive.wp(0.045),
            child: CircularProgressIndicator(
              color: Appcolor.accent,
              strokeWidth: 2,
            ),
          )
        else
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Appcolor.accent,
            inactiveTrackColor: Appcolor.panelEdge,
            inactiveThumbColor: Appcolor.muted,
          ),
      ],
    );
  }
}
