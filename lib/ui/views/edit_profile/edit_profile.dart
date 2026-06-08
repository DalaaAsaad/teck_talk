import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/edit_profile_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/bio_input.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/header.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/profile_avatar.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/profile_field.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/section_title.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/social_link.dart';

class EditProfile extends GetView<EditProfileController> {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Column(
          children: [
            Header(onSavePressed: controller.saveProfile),
            Container(
              height: screenWidth(0.52),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(50),
                  vertical: screenWidth(40),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenWidth(40)),
                    Obx(
                      () => ProfileAvatar(
                        imagePath: controller.avatarImagePath.value,
                        onEditTap: controller.pickAvatarImage,
                      ),
                    ),
                    SizedBox(height: screenWidth(40)),
                    Center(
                      child: Obx(
                        () => CustomText(
                          text: controller.displayName.value,
                          styleType: TextStyleType.CUSTOM,
                          textColor: Appcolor.white,
                          fontSize: screenWidth(18),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth(24)),
                    SectionTitle(title: 'BASIC INFO', size: 15),
                    SizedBox(height: screenWidth(15)),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileField(
                            label: 'First name',
                            controller: controller.firstNameController,
                          ),
                        ),
                        SizedBox(width: screenWidth(30)),
                        Expanded(
                          child: ProfileField(
                            label: 'Last name',
                            controller: controller.lastNameController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth(25)),
                    ProfileField(
                      label: 'Username',
                      controller: controller.usernameController,
                    ),
                    SizedBox(height: screenWidth(25)),

                    Obx(
                      () => BioInput(
                        controller: controller.bioController,
                        maxLength: EditProfileController.bioMaxLength,
                        currentLength: controller.bioLength.value,
                      ),
                    ),
                    SizedBox(height: screenWidth(24)),
                    SectionTitle(title: 'INTERESTS', size: 20),
                    CustomText(
                      text:
                          "Select your interests to personalize your experience",
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.gray_60,
                      fontSize: screenWidth(25),
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: screenWidth(25)),
                    Obx(
                      () => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: EditProfileController.availableInterests.map((
                          interest,
                        ) {
                          final isSelected = controller.selectedInterests
                              .contains(interest);
                          return GestureDetector(
                            onTap: () => controller.toggleInterest(interest),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth(20),
                                vertical: screenWidth(40),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? Appcolor.yellow_70
                                      : Appcolor.gray_60,
                                  width: 1.5,
                                ),
                                color: isSelected
                                    ? Appcolor.yellow_70.withAlpha(30)
                                    : Colors.transparent,
                              ),
                              child: Text(
                                interest,
                                style: TextStyle(
                                  color: isSelected
                                      ? Appcolor.yellow_70
                                      : Appcolor.gray_60,
                                  fontSize: screenWidth(24),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: screenWidth(24)),
                    SectionTitle(title: 'SOCIAL LINKS', size: 20),
                    SizedBox(height: screenWidth(40)),
                    SocialLinkRow(
                      assetPath: 'assets/images/png/facebook.png',
                      controller: controller.facebookController,
                    ),
                    SizedBox(height: screenWidth(40)),
                    SocialLinkRow(
                      assetPath: 'assets/images/png/insta.png',
                      controller: controller.instagramController,
                    ),
                    SizedBox(height: screenWidth(40)),
                    SocialLinkRow(
                      assetPath: 'assets/images/png/Twitter.png',
                      controller: controller.xController,
                    ),
                    SizedBox(height: screenWidth(40)),
                    SocialLinkRow(
                      assetPath: 'assets/images/png/reddit.png',
                      controller: controller.redditController,
                    ),
                    SizedBox(height: screenWidth(40)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
