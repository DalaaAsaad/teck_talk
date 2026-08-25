import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/homecontroller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/custom_widget/post_card.dart';

class ListPostsBody extends GetView<Homecontroller> {
  const ListPostsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.posts.isEmpty) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Appcolor.accent),
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
        padding: EdgeInsetsDirectional.only(bottom: Responsive.hp(0.09)),
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: posts.length + (controller.isLoadingMore.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == posts.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Appcolor.accent),
                ),
              ),
            );
          }

          return PostCard(
            userName: posts[index].user.username,
            userAvatarUrl: posts[index].user.avatarUrl,
            createdAt: posts[index].createdAt,
            title: posts[index].title,
            body: posts[index].body,
            tags: posts[index].tags.map((e) => e.name).toList(),
            photoUrls: posts[index].photos.map((p) => p.url).toList(),
            code: posts[index].code,
            codeLanguage: posts[index].codeLanguage,
            likesCount: posts[index].likesCount,
            commentsCount: posts[index].commentsCount,
            viewsCount: posts[index].viewsCount, // متوفر بالهوم
            isLikedByUser: posts[index].isLikedByUser,
            isSaved: posts[index].isSaved,
            onFavorite: () => controller.toggleFavorite(posts[index]),
            onComment: () => controller.toggleComment(posts[index]),
            onSaved: () => controller.toggleSaved(posts[index]),
            isOwner: posts[index].user.id == controller.currentUserId,
            onEdit: () =>
                Get.toNamed(AppRoutes.editPost, arguments: posts[index]),
            onDelete: () => controller.toggleDelete(posts[index]),
          );
        },
      );
    });
  }
}
