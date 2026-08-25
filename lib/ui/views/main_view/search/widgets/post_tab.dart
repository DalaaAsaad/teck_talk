import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/custom_widget/post_card.dart';

class PostTab extends GetView<Search_Controller> {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // إذا بدك الفلاتر رجعيها:
        // _buildInlineFilters(),
        Expanded(child: _buildPostsList()),
      ],
    );
  }

  // ============================================================
  // POSTS LIST
  // ============================================================

  Widget _buildPostsList() {
    return Obx(() {
      final posts = controller.posts;

      // No results
      if (!controller.isLoading.value &&
          posts.isEmpty &&
          controller.isSearching) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.08)),
            child: CustomText(
              text: 'No posts found for this search',
              styleType: TextStyleType.BODY,
              textColor: Appcolor.muted,
            ),
          ),
        );
      }

      // Loading
      if (controller.isLoading.value && posts.isEmpty) {
        return Center(
          child: SizedBox(
            width: Responsive.wp(0.07),
            height: Responsive.wp(0.07),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Appcolor.accent,
            ),
          ),
        );
      }

      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: Responsive.hp(0.008),
          bottom: Responsive.hp(0.12),
        ),
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
            isOwner: posts[index].user.id == controller.currentUserId,
            onFavorite: () => controller.toggleFavorite(post),
            onComment: () => controller.toggleComment(post),
            onSaved: () => controller.toggleSaved(post),
            onEdit: () {},
            onDelete: () => controller.toggleDelete(post),
            // dense: true,
            showDivider: index != posts.length - 1,
          );
        },
      );
    });
  }

  // ============================================================
  // FILTERS
  // ============================================================

  Widget _buildInlineFilters() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: controller.toggleFilters,
            borderRadius: BorderRadius.circular(Responsive.wp(0.025)),
            child: Padding(
              padding: EdgeInsets.only(top: Responsive.hp(0.012)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "Apply filters",
                    textColor: Appcolor.accent,
                    styleType: TextStyleType.BODY,
                  ),

                  SizedBox(width: Responsive.wp(0.02)),

                  Icon(
                    controller.isShowFilters.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.055),
                  ),
                ],
              ),
            ),
          ),

          if (controller.isShowFilters.value) ...[
            _buildFilterChips(),

            if (controller.selectedFilters.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: Responsive.hp(0.015),
                  bottom: Responsive.hp(0.01),
                ),
                child: Row(
                  children: [
                    CustomText(
                      text: '${controller.selectedFilters.length} selected',
                      styleType: TextStyleType.BODY,
                      textColor: Appcolor.muted,
                    ),

                    const Spacer(),

                    InkWell(
                      onTap: controller.clearSelectedFilters,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.wp(0.02),
                          vertical: Responsive.hp(0.006),
                        ),
                        child: CustomText(
                          text: 'Clear',
                          styleType: TextStyleType.BODY,
                          textColor: Appcolor.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // FILTER CHIPS
  // ============================================================

  Widget _buildFilterChips() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: Responsive.hp(0.012)),
      child: Wrap(
        spacing: Responsive.wp(0.02),
        runSpacing: Responsive.hp(0.01),
        children: controller.allFilters.map((filter) {
          final isSelected = controller.selectedFilters.contains(filter);

          return InkWell(
            onTap: () => controller.toggleFilter(filter),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.wp(0.035),
                vertical: Responsive.hp(0.008),
              ),
              decoration: BoxDecoration(
                color: isSelected ? Appcolor.accent : Appcolor.panel,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected ? Appcolor.accent : Appcolor.panelEdge,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Appcolor.accent.withOpacity(0.20),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: CustomText(
                text: filter,
                styleType: TextStyleType.BODY,
                textColor: isSelected ? Appcolor.white : Appcolor.muted,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
