import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class PublishSwitchTile extends StatelessWidget {
  final bool isPublished;
  final ValueChanged<bool> onChanged;

  const PublishSwitchTile({
    super.key,
    required this.isPublished,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Responsive.wp(0.1),
          height: Responsive.wp(0.1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isPublished ? Appcolor.successDim : Appcolor.panelEdge,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isPublished ? Icons.public_rounded : Icons.lock_outline_rounded,
            color: isPublished ? Appcolor.success : Appcolor.muted,
            size: Responsive.sp(0.045),
          ),
        ),
        SizedBox(width: Responsive.wp(0.035)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Published',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.038),
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: Responsive.hp(0.003)),
              CustomText(
                text: isPublished ? 'Visible to everyone' : 'Saved as draft',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.muted,
                fontSize: Responsive.sp(0.031),
              ),
            ],
          ),
        ),
        Switch(
          value: isPublished,
          onChanged: onChanged,
          activeColor: Appcolor.accent,
          inactiveTrackColor: Appcolor.panelEdge,
          inactiveThumbColor: Appcolor.muted,
        ),
      ],
    );
  }
}