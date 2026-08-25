import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/image_url_helper.dart';

class ProfileSection extends GetView<CreatePostController> {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarUrl = resolveImageUrl(
      SharedPreferenceRepository().getUserAvatarUrl(),
    );

    return Row(
      children: [
        Container(
          width: Responsive.wp(0.11),
          height: Responsive.wp(0.11),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Appcolor.accent.withOpacity(0.5)),
          ),
          padding: const EdgeInsets.all(2),
          child: ClipOval(
            child: avatarUrl == null
                ? Image.asset(
                    'assets/images/png/profile.png',
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/png/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),

        SizedBox(width: Responsive.wp(0.03)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: SharedPreferenceRepository().getUserUserName() ?? 'User',
              styleType: TextStyleType.CUSTOM,
              fontSize: Responsive.sp(0.042),
              fontWeight: FontWeight.w700,
              textColor: Appcolor.white,
            ),
            CustomText(
              text: "Posting publicly",
              styleType: TextStyleType.SMALL,
              textColor: Appcolor.muted,
            ),
          ],
        ),
      ],
    );
  }
}
