import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class UserInfoProfile extends GetView<ProfileController> {
  const UserInfoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profileData.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: screenWidth(13),
          backgroundImage: profile?.avatarUrl.isNotEmpty ?? false
              ? NetworkImage(profile!.avatarUrl)
              : AssetImage('assets/images/png/profile.png'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: profile?.name ?? 'nameProfile',
                  styleType: TextStyleType.CUSTOM,
                  fontSize: screenWidth(22),
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(width: screenWidth(7)),
                Container(
                  height: screenWidth(20),
                  width: screenWidth(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Appcolor.yellow_70,
                  ),
                  child: Center(
                    child: CustomText(
                      text: profile?.badge ?? '',
                      styleType: TextStyleType.SMALL,
                      textColor: Appcolor.black_08,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth(35)),
            CustomText(
              text:
                  '${profile?.postsCount ?? 0} posts      ${profile?.followersCount ?? 0} followers    ${profile?.blogsCount ?? 0} blogs',
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(30),
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ],
    );
  }
}
