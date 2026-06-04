import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/homecontroller.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/home/post_card.dart';

class ListPostsBody extends GetView<Homecontroller> {
  const ListPostsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Appcolor.yellow_70),
            ),
          );
        }

        final posts = controller.posts;

        if (posts.isEmpty) {
          return Center(
            child: Text(
              'No posts found',
              style: TextStyle(color: Appcolor.white),
            ),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: screenWidth(35),
            bottom: screenWidth(8),
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(
              post: posts[index],
              onFavorite: () => controller.toggleFavorite(posts[index]),
              onComment: () => controller.toggleComment(posts[index]),
              onSaved: () => controller.toggleSaved(posts[index]),
            );
          },
        );
      }),
    );
  }
}
