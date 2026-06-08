import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/responses/saved_item_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/blog_saved_card.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/post_saved_card.dart';

class TabbarProfile extends GetView<ProfileController> {
  const TabbarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorColor: Appcolor.yellow_70,
          labelColor: Appcolor.yellow_70,
          unselectedLabelColor: Appcolor.gray_95,
          tabs: [
            Tab(icon: Icon(Icons.grid_view_rounded)),
            Tab(icon: Icon(Icons.bookmark_border)),
          ],
        ),

        Expanded(
          child: TabBarView(
            children: [
              // Posts

              // Saved
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: screenWidth(5)),
                child: ListView.builder(
                  itemCount:
                      controller.myPostsAndDrafts.value?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = controller.myPostsAndDrafts.value!.data[index];

                    if (item.isPublished) {
                      return PostSavedCard(
                        post: item,
                        onFavorite: () {},
                        onComment: () {},
                        onSaved: () {},
                      );
                    } else {
                      return PostSavedCard(
                        post: item,
                        isDraft: item.isPublished ? false : true,
                        onFavorite: () {},
                        onComment: () {},
                        onSaved: () {},
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(bottom: screenWidth(5)),
                child: ListView.builder(
                  itemCount: controller.savedItems.value?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = controller.savedItems.value!.data[index];

                    if (item.kind == 'blog') {
                      final blog = item.data as BlogListSavedModel;
                      return BlogSavedCard(blog: blog);
                    }
                    if (item.kind == 'post') {
                      final post = item.data as PostSavedModel;
                      return PostSavedCard(
                        post: post,
                        onFavorite: () {},
                        onComment: () {},
                        onSaved: () {},
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
