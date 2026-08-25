import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/profile_action_row.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/profile_hero.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/profile_merged_info.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/profile_more_section.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/tabbar_profile.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/top_profile.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

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

      final profile = controller.profileData.value!;

      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Appcolor.bg,
          body: NestedScrollView(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHero(
                          avatarUrl: profile.avatarUrl,
                          coverImageUrl: profile.coverImageUrl,
                          badge: profile.badge,
                          topRightAction: const TopProfile(),
                        ),
                        const ProfileMergedInfo(),
                        SizedBox(height: Responsive.hp(0.012)),
                        const ProfileActionRow(),
                        SizedBox(height: Responsive.hp(0.01)),
                        const ProfileMoreSection(),
                        SizedBox(height: Responsive.hp(0.016)),
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
            body: TabbarProfile(),
          ),
        ),
      );
    });
  }
}
