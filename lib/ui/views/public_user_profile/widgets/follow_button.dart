import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// ملاحظة: بلا SizedBox(width: double.infinity) هون - هلق مستخدمة
/// جوّا Expanded بـ PublicProfileActionRow، فبتاخد عرضها من هناك
/// تلقائياً. لو استخدمتها لحالها بمكان تاني، لفّها بـ SizedBox(width:
/// double.infinity) أو Expanded يدوياً.
class FollowButton extends GetView<UserProfileController> {
  const FollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profileData.value?.data;
    if (profile == null || profile.id == controller.currentUserId) {
      return const SizedBox.shrink();
    }

    return Obx(() {
      final following = controller.isFollowing.value;
      final loading = controller.isFollowLoading.value;

      return SizedBox(
        height: Responsive.hp(0.052),
        width: double.infinity,
        child: OutlinedButton(
          onPressed: loading ? null : controller.toggleFollow,
          style: OutlinedButton.styleFrom(
            backgroundColor: following ? Colors.transparent : Appcolor.accent,
            side: BorderSide(
              color: following ? Appcolor.panelEdge : Appcolor.accent,
              width: 1.2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: loading
              ? SizedBox(
                  width: Responsive.wp(0.04),
                  height: Responsive.wp(0.04),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: following ? Appcolor.muted : Appcolor.white,
                  ),
                )
              : CustomText(
                  text: following ? 'Following' : 'Follow',
                  styleType: TextStyleType.CUSTOM,
                  fontWeight: FontWeight.w700,
                  fontSize: Responsive.sp(0.036),
                  textColor: Appcolor.white,
                ),
        ),
      );
    });
  }
}