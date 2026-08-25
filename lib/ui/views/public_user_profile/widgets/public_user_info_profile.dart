import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/full_screen_images.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class PublicUserInfoProfile extends GetView<UserProfileController> {
  const PublicUserInfoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final profile = controller.profileData.value?.data;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (profile == null) {
        return const SizedBox();
      }

      final hasAvatar =
          profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: hasAvatar
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FullScreenPhotoView(
                          photoUrls: [profile.avatarUrl!],
                        ),
                      ),
                    );
                  }
                : null,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Appcolor.accent, width: 2),
              ),
              child: CircleAvatar(
                radius: Responsive.wp(0.08),
                backgroundColor: Appcolor.panel,
                backgroundImage: hasAvatar
                    ? NetworkImage(profile.avatarUrl!)
                    : const AssetImage('assets/images/png/profile.png')
                        as ImageProvider,
              ),
            ),
          ),

          SizedBox(width: Responsive.wp(0.035)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomText(
                        text: profile.name,
                        styleType: TextStyleType.CUSTOM,
                        fontSize: Responsive.sp(0.046),
                        fontWeight: FontWeight.w700,
                        textColor: Appcolor.white,
                      ),
                    ),
                    if ((profile.badge ?? '').isNotEmpty) ...[
                      SizedBox(width: Responsive.wp(0.018)),
                      Container(
                        constraints: BoxConstraints(
                          minWidth: Responsive.wp(0.06),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.wp(0.018),
                          vertical: Responsive.hp(0.003),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: Appcolor.accentDim,
                        ),
                        child: CustomText(
                          text: profile.badge ?? '',
                          styleType: TextStyleType.SMALL,
                          textColor: Appcolor.accent,
                          fontSize: Responsive.sp(0.024),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),

                SizedBox(height: Responsive.hp(0.01)),

                Wrap(
                  spacing: Responsive.wp(0.035),
                  runSpacing: Responsive.hp(0.004),
                  children: [
                    _StatText(value: profile.postsCount, label: 'posts'),
                    // بنستخدم controller.followersCount التفاعلية (مش
                    // profile.followersCount الثابتة) حتى تنعكس بلحظتها
                    // لما يصير Follow/Unfollow.
                    _StatText(
                      value: controller.followersCount.value,
                      label: 'followers',
                    ),
                    _StatText(value: profile.blogsCount, label: 'blogs'),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _StatText extends StatelessWidget {
  final int value;
  final String label;

  const _StatText({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$value ',
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.032),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: label,
            style: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.032),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}