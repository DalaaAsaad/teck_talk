import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:teck_talk/controllers/profile_controller.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

enum ProfileMenuAction { activity, settings, logout }

class TopProfile extends GetView<ProfileController> {
  const TopProfile({super.key});
  void _onMenuSelected(ProfileMenuAction action) {
    switch (action) {
      case ProfileMenuAction.activity:
        // TODO: connect to activity screen
        break;
      case ProfileMenuAction.settings:
        // TODO: connect to settings screen
        break;
      case ProfileMenuAction.logout:
        // TODO: connect to logout flow
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = controller.profileData.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: profile?.username ?? "",
          styleType: TextStyleType.CUSTOM,
          fontSize: screenWidth(20),
          fontWeight: FontWeight.w300,
        ),
        Theme(
          data: Theme.of(context).copyWith(
            popupMenuTheme: PopupMenuThemeData(
              color: const Color(0xFF2B2B2B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          child: PopupMenuButton<ProfileMenuAction>(
            color: Appcolor.dark_20,
            onSelected: _onMenuSelected,
            icon: Icon(Icons.more_vert, color: Appcolor.gray_95),
            elevation: 8,
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              PopupMenuItem<ProfileMenuAction>(
                value: ProfileMenuAction.activity,
                child: _MenuItemRow(icon: Icons.timeline, label: 'My Activity'),
              ),
              PopupMenuItem<ProfileMenuAction>(
                value: ProfileMenuAction.settings,
                child: _MenuItemRow(icon: Icons.settings, label: 'Settings'),
              ),
              PopupMenuItem<ProfileMenuAction>(
                value: ProfileMenuAction.logout,
                child: _MenuItemRow(icon: Icons.logout, label: 'Log Out'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuItemRow extends StatelessWidget {
  const _MenuItemRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Appcolor.yellow_70, size: 18),
        SizedBox(width: screenWidth(45)),
        CustomText(
          text: label,
          styleType: TextStyleType.BODY,
          textColor: Appcolor.white,
        ),
      ],
    );
  }
}
