import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// زر مضغوط بالزاوية (بدل قائمة التلات نقط القديمة). حالتين بصريتين:
/// - عادي: حدود رمادية خفيفة + "Block".
/// - محظور: خلفية/حدود حمراء + "Unblock" - إشارة واضحة إنو في إجراء
///   نشط عالحساب هلق.
class BlockButton extends GetView<UserProfileController> {
  const BlockButton({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profileData.value?.data;
    if (profile == null || profile.id == controller.currentUserId) {
      return const SizedBox.shrink();
    }

    return Obx(() {
      final blocked = controller.isBlocked.value;
      final loading = controller.isBlockLoading.value;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: loading ? null : controller.toggleBlock,
          borderRadius: BorderRadius.circular(999),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.03),
              vertical: Responsive.hp(0.008),
            ),
            decoration: BoxDecoration(
              color: blocked
                  ? Appcolor.danger.withOpacity(0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: blocked
                    ? Appcolor.danger.withOpacity(0.5)
                    : Appcolor.panelEdge,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (loading)
                  SizedBox(
                    width: Responsive.wp(0.032),
                    height: Responsive.wp(0.032),
                    child: CircularProgressIndicator(
                      strokeWidth: 1.8,
                      color: blocked ? Appcolor.danger : Appcolor.muted,
                    ),
                  )
                else
                  Icon(
                    blocked ? Icons.block_rounded : Icons.block_outlined,
                    size: Responsive.sp(0.034),
                    color: blocked ? Appcolor.danger : Appcolor.muted,
                  ),
                SizedBox(width: Responsive.wp(0.014)),
                CustomText(
                  text: blocked ? 'Unblock' : 'Block',
                  styleType: TextStyleType.CUSTOM,
                  fontSize: Responsive.sp(0.03),
                  fontWeight: FontWeight.w600,
                  textColor: blocked ? Appcolor.danger : Appcolor.muted,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
