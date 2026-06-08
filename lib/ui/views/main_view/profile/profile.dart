import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/bio_profile.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/button_profile.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/social_item.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/tabbar_profile.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/top_profile.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/user_info_profile.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/xpbar_profile.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value || controller.profileData.value == null) {
        return const Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: CircularProgressIndicator(color: Appcolor.yellow_70),
          ),
        );
      }

      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Appcolor.black_08,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: screenWidth(20),
                      end: screenWidth(40),
                    ),
                    child: Column(
                      children: [
                        TopProfile(),
                        UserInfoProfile(),
                        BioProfile(),
                        XpbarProfile(),
                        ButtonProfile(),
                        rowSocialItem(),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabbarProfile(),
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
      SocialItem(iconPath: 'assets/images/png/facebook.png'),
      SocialItem(iconPath: 'assets/images/png/insta.png'),
      SocialItem(iconPath: 'assets/images/png/Twitter.png', tintWhite: true),
      SocialItem(iconPath: 'assets/images/png/reddit.png'),
    ],
  );
}
