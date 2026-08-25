import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/account_tab.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/blog_tab.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/post_tab.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/tab_icon.dart';

class TabBarSection extends GetView<Search_Controller> {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.wp(0.008)),
            decoration: BoxDecoration(
              color: Appcolor.panel,
              borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: Appcolor.accentDim,
                borderRadius: BorderRadius.circular(Responsive.wp(0.022)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Appcolor.accent,
              unselectedLabelColor: Appcolor.muted,
              labelStyle: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                TabIcon(icon: Icons.article_rounded, label: 'Posts'),
                TabIcon(icon: Icons.person_rounded, label: 'Accounts'),
                TabIcon(icon: Icons.post_add_rounded, label: 'Blogs'),
              ],
            ),
          ),
          SizedBox(height: Responsive.hp(0.01)),
          Expanded(
            child: TabBarView(
              children: [const PostTab(), AccountTab(), BlogTab()],
            ),
          ),
        ],
      ),
    );
  }
}