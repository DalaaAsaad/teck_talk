import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/public_bio_profile.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/public_profile_action_row.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/public_user_info_profile.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/tabbar_profile.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/top_user_profile.dart';
import 'package:tech_talk/ui/views/public_user_profile/widgets/xpba_public_user_profile.dart';

class UserProfile extends GetView<UserProfileController> {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value || controller.profileData.value == null) {
        return Scaffold(
          backgroundColor: Appcolor.bg,
          body: Center(
            child: CircularProgressIndicator(color: Appcolor.accent),
          ),
        );
      }

      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Appcolor.bg,
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: Responsive.wp(0.045),
                        end: Responsive.wp(0.045),
                        top: Responsive.hp(0.012),
                      ),
                      child: Column(
                        children: [
                          const TopUserProfile(),
                          SizedBox(height: Responsive.hp(0.01)),
                          const PublicUserInfoProfile(),
                          SizedBox(height: Responsive.hp(0.016)),
                          SizedBox(height: Responsive.hp(0.016)),
                          const PublicBioProfile(),
                          const PublicProfileActionRow(),
                          SizedBox(height: Responsive.hp(0.03)),
                          const XpbaPublicUserProfile(),
                          SizedBox(height: Responsive.hp(0.01)),
                          rowSocialItem(),
                          SizedBox(height: Responsive.hp(0.012)),
                          Container(
                            height: 1,
                            color: Appcolor.panelEdge.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: const TabbarProfile(),
            ),
          ),
        ),
      );
    });
  }
}

Widget rowSocialItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // SocialItem(iconPath: 'assets/images/png/facebook.png'),
      // SocialItem(iconPath: 'assets/images/png/insta.png'),
      // SocialItem(iconPath: 'assets/images/png/Twitter.png', tintWhite: true),
      // SocialItem(iconPath: 'assets/images/png/reddit.png'),
    ],
  );
}
