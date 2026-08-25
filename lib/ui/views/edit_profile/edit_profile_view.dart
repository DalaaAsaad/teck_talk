import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tech_talk/Binding/change_pesonal_info_binding.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/edit_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/image_url_helper.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/glass_input_field.dart';

import 'package:tech_talk/ui/views/edit_blog/widgets/tags_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_picker_sheet.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/change_personal_info_view.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/elevated_card.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/multiline_glass_field.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/profile_hero_images.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/social_link_field.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/top_bar_edit_profile.dart';

class EditProfile extends GetView<EditProfileController> {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => TopBarEditProfile(
                isOnboarding: controller.isOnboarding,
                isSaving: controller.isSaving.value,
                isSaved: controller.isSaved.value,
                onSave: controller.saveProfile,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.hp(0.006)),
                    Obx(() => _buildHeroImages()),
                    ElevatedCard(
                      title: 'General Info',
                      child: Column(
                        children: [
                          MultilineGlassField(
                            controller: controller.bioController,
                            hintText:
                                "Tell the community what you're building…",
                          ),
                          SizedBox(height: Responsive.hp(0.014)),
                          GlassInputField(
                            controller: controller.websiteController,
                            hintText: 'Website (https://...)',
                          ),
                          SizedBox(height: Responsive.hp(0.014)),
                          GlassInputField(
                            controller: controller.locationController,
                            hintText: 'Location (optional)',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.016)),
                    ElevatedCard(title: 'Interests', child: _buildTagsField()),
                    SizedBox(height: Responsive.hp(0.016)),
                    ElevatedCard(
                      title: 'Social Links',
                      child: Column(
                        children: [
                          SocialLinkField(
                            icon: const FaIcon(FontAwesomeIcons.facebook),
                            iconColor: const Color(0xFF1877F2),
                            hint: 'https://facebook.com/username',
                            controller: controller
                                .socialControllers[SocialPlatform.facebook]!,
                          ),
                          SizedBox(height: Responsive.hp(0.01)),
                          SocialLinkField(
                            icon: const FaIcon(FontAwesomeIcons.instagram),
                            iconColor: const Color(0xFFE1306C),
                            hint: 'https://instagram.com/username',
                            controller: controller
                                .socialControllers[SocialPlatform.instagram]!,
                          ),
                          SizedBox(height: Responsive.hp(0.01)),
                          SocialLinkField(
                            icon: const FaIcon(FontAwesomeIcons.xTwitter),
                            iconColor: const Color(0xFF1DA1F2),
                            hint: 'https://twitter.com/username',
                            controller:
                                controller.socialControllers[SocialPlatform.x]!,
                          ),
                          SizedBox(height: Responsive.hp(0.01)),
                          SocialLinkField(
                            icon: const FaIcon(FontAwesomeIcons.reddit),
                            iconColor: const Color(0xFFFF4500),
                            hint: 'https://reddit.com/u/username',
                            controller: controller
                                .socialControllers[SocialPlatform.reddit]!,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.016)),
                    _buildChangePersonalInfoRow(),
                    SizedBox(height: Responsive.hp(0.03)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePersonalInfoRow() {
    return InkWell(
      onTap: () async {
        final arguments = {
          'name': controller.initialName,
          'email': controller.initialEmail,
          'username': controller.initialUsername,
        };

        try {
          await Get.toNamed(AppRoutes.changePersonalInfo, arguments: arguments);
        } catch (_) {
          await Get.to(
            () => const ChangePersonalInfoView(),
            arguments: arguments,
            binding: changePersonalInfoBinding(),
          );
        }
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.wp(0.04),
          vertical: Responsive.hp(0.016),
        ),
        decoration: BoxDecoration(
          color: Appcolor.panel,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Appcolor.panelEdge),
        ),
        child: Row(
          children: [
            Icon(
              Icons.lock_outline_rounded,
              color: Appcolor.muted,
              size: Responsive.sp(0.045),
            ),
            SizedBox(width: Responsive.wp(0.03)),
            Expanded(
              child: CustomText(
                text: 'Change personal information',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.037),
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Appcolor.muted,
              size: Responsive.sp(0.05),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsField() {
    return Obx(() {
      final selectedNames = controller.availableTags
          .where((tag) => controller.selectedTagIds.contains(tag.id))
          .map((tag) => tag.name)
          .toList();

      return TagsField(
        selectedTagNames: selectedNames,
        onTap: () => showTagsPickerSheet(
          availableTags: controller.availableTags,
          selectedTagIds: controller.selectedTagIds,
          isLoadingTags: controller.isLoadingTags,
        ),
      );
    });
  }

  Widget _buildHeroImages() {
    Widget? coverPreview;
    if (controller.newCoverImage.value != null) {
      coverPreview = Image.file(
        File(controller.newCoverImage.value!.path),
        fit: BoxFit.cover,
      );
    } else if (controller.existingCoverUrl.value != null &&
        !controller.removeCoverImage.value) {
      final url = resolveImageUrl(controller.existingCoverUrl.value!);
      coverPreview = Image.network(url ?? '', fit: BoxFit.cover);
    }

    Widget? avatarPreview;
    if (controller.newAvatar.value != null) {
      avatarPreview = Image.file(
        File(controller.newAvatar.value!.path),
        fit: BoxFit.cover,
      );
    } else if (controller.existingAvatarUrl.value != null &&
        !controller.removeAvatar.value) {
      final url = resolveImageUrl(controller.existingAvatarUrl.value!);
      avatarPreview = Image.network(url ?? '', fit: BoxFit.cover);
    }

    return ProfileHeroImages(
      coverPreview: coverPreview,
      avatarPreview: avatarPreview,
      hasCover: controller.hasCoverImage,
      hasAvatar: controller.hasAvatar,
      onPickCover: controller.pickCoverImage,
      onPickAvatar: controller.pickAvatar,
      onRemoveCover: controller.removeCoverImagePic,
      onRemoveAvatar: controller.removeAvatarImage,
    );
  }
}
