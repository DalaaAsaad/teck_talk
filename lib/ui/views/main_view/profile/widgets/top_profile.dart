import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TopProfile extends GetView<ProfileController> {
  const TopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ProfileMenuAction>(
      color: Appcolor.panel,
      onSelected: controller.onMenuSelected,
      icon: Container(
        width: Responsive.wp(0.09),
        height: Responsive.wp(0.09),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Appcolor.bg.withOpacity(0.7),
          shape: BoxShape.circle,
          border: Border.all(color: Appcolor.panelEdge),
        ),
        child: Icon(
          Icons.more_vert_rounded,
          color: Appcolor.white,
          size: Responsive.sp(0.05),
        ),
      ),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.3),
      surfaceTintColor: Appcolor.panel,
      position: PopupMenuPosition.under,
      offset: Offset(0, Responsive.hp(0.01)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      constraints: BoxConstraints(minWidth: Responsive.wp(0.44)),
      itemBuilder: (context) => [
        PopupMenuItem<ProfileMenuAction>(
          value: ProfileMenuAction.activity,
          height: Responsive.hp(0.06),
          child: _MenuItemRow(
            icon: Icons.timeline_rounded,
            label: 'My Activity',
          ),
        ),
        PopupMenuItem<ProfileMenuAction>(
          value: ProfileMenuAction.settings,
          height: Responsive.hp(0.06),
          child: _MenuItemRow(icon: Icons.settings_rounded, label: 'Settings'),
        ),
        PopupMenuItem<ProfileMenuAction>(
          value: ProfileMenuAction.logout,
          height: Responsive.hp(0.06),
          child: _MenuItemRow(
            icon: Icons.logout_rounded,
            label: 'Log Out',
            iconColor: const Color(0xFFE05C5C),
            labelColor: const Color(0xFFE05C5C),
          ),
        ),
      ],
    );
  }
}

class _MenuItemRow extends StatelessWidget {
  const _MenuItemRow({
    required this.icon,
    required this.label,
    this.iconColor,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.03),
        vertical: Responsive.hp(0.004),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.wp(0.075),
            height: Responsive.wp(0.075),
            decoration: BoxDecoration(
              color: Appcolor.accentDim,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: iconColor ?? Appcolor.accent,
              size: Responsive.sp(0.036),
            ),
          ),
          SizedBox(width: Responsive.wp(0.03)),
          CustomText(
            text: label,
            styleType: TextStyleType.SMALL,
            textColor: labelColor ?? Appcolor.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
