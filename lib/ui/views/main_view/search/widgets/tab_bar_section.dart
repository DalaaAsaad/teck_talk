import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/search_controller.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/account_tab.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/blog_tab.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/post_tab.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/tab_icon.dart';

class TabBarSection extends GetView<search_Controller> {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            indicatorColor: Appcolor.yellow_70,
            labelColor: Appcolor.yellow_70,
            unselectedLabelColor: Appcolor.gray_95,
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            tabs: const [
              TabIcon(icon: Icons.article, label: 'Posts'),
              TabIcon(icon: Icons.person, label: 'Accounts'),
              TabIcon(icon: Icons.post_add, label: 'Blogs'),
            ],
          ),
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
