import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/user_profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/blog_card.dart';
import 'package:tech_talk/ui/shared/custom_widget/post_card.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TabbarProfile extends GetView<UserProfileController> {
  const TabbarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ============================================================
        // TAB BAR — نفس ستايل صفحة البروفايل الشخصي (Pill indicator).
        // ============================================================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
          child: Container(
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
              splashBorderRadius: BorderRadius.circular(Responsive.wp(0.022)),
              tabs: [
                Tab(
                  height: Responsive.hp(0.045),
                  icon: Icon(
                    Icons.grid_view_rounded,
                    size: Responsive.sp(0.05),
                  ),
                ),
                Tab(
                  height: Responsive.hp(0.045),
                  icon: Icon(
                    Icons.menu_book_rounded,
                    size: Responsive.sp(0.05),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: Responsive.hp(0.01)),

        Expanded(
          child: TabBarView(
            children: [_PostsTab(), _BlogsTab()],
          ),
        ),

        SizedBox(height: Responsive.hp(0.065)),
      ],
    );
  }
}

class _PostsTab extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isPostsLoading.value && controller.posts.isEmpty) {
        return Center(
          child: CircularProgressIndicator(color: Appcolor.accent),
        );
      }

      final posts = controller.posts;

      if (posts.isEmpty) {
        return const _EmptyState(
          icon: Icons.grid_view_rounded,
          text: 'No posts yet',
        );
      }

      return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(
            userName: post.user.username,
            userAvatarUrl: post.user.avatarUrl,
            createdAt: post.createdAt,
            title: post.title,
            body: post.body,
            tags: post.tags.map((e) => e.name).toList(),
            photoUrls: post.photos.map((p) => p.url).toList(),
            code: post.code,
            codeLanguage: post.codeLanguage,
            likesCount: post.likesCount,
            commentsCount: post.commentsCount,
            viewsCount: post.viewsCount,
            isLikedByUser: post.isLikedByUser,
            isSaved: post.isSaved,
            onFavorite: () => controller.toggleFavorite(post),
            onComment: () => controller.toggleComment(post),
            onSaved: () => controller.toggleSaved(post),
            isOwner: false,
            showDivider: index != (posts.length - 1),
          );
        },
      );
    });
  }
}

class _BlogsTab extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isBlogsLoading.value && controller.blogs.isEmpty) {
        return Center(
          child: CircularProgressIndicator(color: Appcolor.accent),
        );
      }

      final blogs = controller.blogs;

      if (blogs.isEmpty) {
        return const _EmptyState(
          icon: Icons.menu_book_rounded,
          text: 'No blogs yet',
        );
      }

      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent - 200) {
            controller.loadMoreUserBlogs();
          }
          return false;
        },
        child: ListView.builder(
          padding: EdgeInsets.only(
            top: Responsive.hp(0.006),
            bottom: Responsive.hp(0.02),
          ),
          itemCount: blogs.length + (controller.isBlogsLoadingMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == blogs.length) {
              return Padding(
                padding: EdgeInsets.all(Responsive.wp(0.04)),
                child: Center(
                  child: CircularProgressIndicator(color: Appcolor.accent),
                ),
              );
            }

            final blog = blogs[index];
            return BlogCard(
              title: blog.title,
              subtitle: blog.subtitle,
              coverImageUrl: blog.coverImageUrl,
              tags: blog.tags.map((t) => t.name).toList(),
              authorName: blog.user.name,
              authorAvatarUrl: blog.user.avatarUrl,
              createdAt: blog.createdAt.toString(),
              onReadMore: () {
                Get.toNamed(AppRoutes.blogView, arguments: blog.id);
              },
            );
          },
        ),
      );
    });
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String text;

  const _EmptyState({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Responsive.wp(0.16),
            height: Responsive.wp(0.16),
            decoration: BoxDecoration(
              color: Appcolor.panel,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Appcolor.muted, size: Responsive.sp(0.06)),
          ),
          SizedBox(height: Responsive.hp(0.014)),
          Text(
            text,
            style: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.034),
            ),
          ),
        ],
      ),
    );
  }
}