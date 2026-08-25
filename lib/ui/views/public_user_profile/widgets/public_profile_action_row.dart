import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/follow_button.dart';

/// نفس بنية ProfileActionRow بالبروفايل الشخصي - Follow ممتد + Share
/// دائرية جنبه. Block مش هون - هي بالزاوية جوّا TopUserProfile.
class PublicProfileActionRow extends GetView<UserProfileController> {
  const PublicProfileActionRow({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profileData.value?.data;

    if (profile == null || profile.id == controller.currentUserId) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        const Expanded(child: FollowButton()),
        SizedBox(width: Responsive.wp(0.025)),
        _ShareIconButton(),
      ],
    );
  }
}

class _ShareIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => AppSnackBar.success('Profile link shared'),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: Responsive.hp(0.048),
          height: Responsive.hp(0.048),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Appcolor.panel,
            shape: BoxShape.circle,
            border: Border.all(color: Appcolor.panelEdge.withOpacity(0.6)),
          ),
          child: Icon(
            Icons.share_rounded,
            color: Appcolor.white,
            size: Responsive.sp(0.045),
          ),
        ),
      ),
    );
  }
}
