import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/responses/saved_item_response.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/blog_card.dart';
import 'package:tech_talk/ui/shared/custom_widget/post_card.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TabbarProfile extends GetView<ProfileController> {
  const TabbarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ============================================================
        // TAB BAR — pill indicator جوا كونتينر ناعم، متل ستايل السيرش
        // ============================================================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
          child: Container(
            // padding: EdgeInsets.all(Responsive.wp(0.008)),
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
                    Icons.bookmark_border_rounded,
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
            children: [
              // =========================
              // My Posts & Drafts
              // =========================
              Obx(() {
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
                      userName: post.user.name,
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
                      isOwner: post.user.id == controller.currentUserId,
                      onEdit: () => Get.toNamed(
                        AppRoutes.editPost,
                        arguments: posts[index],
                      ),
                      onDelete: () => controller.toggleDelete(post),
                      showDivider: index != (posts.length - 1),
                    );
                  },
                );
              }),

              // =========================
              // Saved
              // =========================
              Obx(() {
                final items = controller.savedItems.value?.data ?? [];

                if (items.isEmpty) {
                  return const _EmptyState(
                    icon: Icons.bookmark_border_rounded,
                    text: 'No saved items yet',
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.only(
                    top: Responsive.hp(0.006),
                    bottom: Responsive.hp(0.02),
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    if (item.kind == 'blog') {
                      final blog = item.data as BlogListSavedModel;
                      return BlogCard(
                        title: blog.title,
                        subtitle: blog.subtitle,
                        coverImageUrl: blog.coverImageUrl,
                        tags: const [
                          "Flutter",
                          "Front End",
                        ], // أو من blog.tags إذا موجودة
                        authorName: blog.user.name,
                        authorAvatarUrl: "assets/images/png/profile.png",
                        createdAt: blog.createdAt,
                        onReadMore: () {
                          Get.toNamed(AppRoutes.blogView, arguments: blog.id);
                        },
                      );
                    }

                    if (item.kind == 'post') {
                      final post = item.data as PostModel;
                      return PostCard(
                        userName: post.user.name,
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
                        isOwner: post.user.id == controller.currentUserId,
                        onEdit: () =>
                            Get.toNamed(AppRoutes.editPost, arguments: post),
                        onDelete: () => controller.toggleDelete(post),
                        showDivider: index != (controller.posts.length - 1),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                );
              }),
            ],
          ),
        ),

        SizedBox(height: Responsive.hp(0.065)),
      ],
    );
  }
}

// ============================================================================
// حالة فاضية موحّدة — widget عادي، بلا أي منطق Rx جواتها
// ============================================================================
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
