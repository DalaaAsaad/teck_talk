import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/blog_view_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/blog_view_header.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/content_preview.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/meta_item.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/metric_chip.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/table_of_contents_card.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/elevated_card.dart';

class BlogView extends GetView<BlogViewController> {
  const BlogView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final blog = controller.blogInfo.value;
              final isOwner =
                  blog != null && blog.user.id == controller.currentUserId;

              if (!isOwner) return const SizedBox.shrink();

              return Padding(
                padding: EdgeInsetsDirectional.only(
                  start: Responsive.wp(0.04),
                  end: Responsive.wp(0.04),
                  top: Responsive.hp(0.006),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _RoundIconButton(
                      icon: Icons.edit_outlined,
                      color: Appcolor.accent,
                      onTap: () async {
                        final result = await Get.toNamed(
                          AppRoutes.editBlog,
                          arguments: controller.blogInfo.value,
                        );
                        if (result == true) {
                          controller.loadBlogInfo();
                        }
                      },
                    ),
                    SizedBox(width: Responsive.wp(0.025)),
                    _RoundIconButton(
                      icon: Icons.delete_outline_rounded,
                      color: Appcolor.danger,
                      onTap: () => _confirmDelete(context),
                    ),
                  ],
                ),
              );
            }),
            Obx(
              () => BlogViewHeader(
                heroImage:
                    controller.blogInfo.value?.coverImageUrl ??
                    "assets/images/png/blog_image.png",
                title: controller.blogInfo.value?.title ?? '',
                subTitle: controller.blogInfo.value?.subtitle ?? '',
                isViewed: controller.blogInfo.value?.isViewed ?? false,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: Responsive.wp(0.06),
                end: Responsive.wp(0.06),
              ),
              child: _buildEngagementRow(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.04)),
                child: Obx(
                  () => SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Responsive.hp(0.02)),
                        ElevatedCard(
                          title: 'Overview',
                          child: _buildMetaGrid(),
                        ),
                        SizedBox(height: Responsive.hp(0.02)),
                        ElevatedCard(
                          title: 'Table of Contents',
                          child: TableOfContentsCard(
                            tableOfContents:
                                controller.blogInfo.value?.sections
                                    .map((section) => section.title)
                                    .toList() ??
                                <String>[],
                          ),
                        ),
                        SizedBox(height: Responsive.hp(0.02)),
                        ElevatedCard(
                          title: 'Content Preview',
                          child: ContentPreview(
                            tableOfContents:
                                controller.blogInfo.value?.sections
                                    .map((section) => section.title)
                                    .toList() ??
                                <String>[],
                            contentMap: controller.blogInfo.value != null
                                ? {
                                    for (final section
                                        in controller.blogInfo.value!.sections)
                                      section.title: section.content,
                                  }
                                : {},
                          ),
                        ),
                        SizedBox(height: Responsive.hp(0.03)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementRow() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MetricChip(
            icon: controller.blogInfo.value?.isLikedByUser == true
                ? Icons.favorite
                : Icons.favorite_border,
            iconColor: const Color(0xFFE0895C),
            label: controller.formatEngagement(
              controller.blogInfo.value?.likesCount,
            ),
            isActive: controller.blogInfo.value?.isLikedByUser ?? false,
            onTap: () => controller.toggleFavorite(controller.blogInfo.value!),
          ),
          SizedBox(width: Responsive.wp(0.03)),
          MetricChip(
            icon: Icons.visibility_outlined,
            iconColor: Appcolor.muted,
            label: controller.formatEngagement(
              controller.blogInfo.value?.viewsCount,
            ),
          ),
          SizedBox(width: Responsive.wp(0.03)),
          MetricChip(
            icon: controller.blogInfo.value?.isSaved == true
                ? Icons.bookmark
                : Icons.bookmark_border_rounded,
            iconColor: Appcolor.accent,
            label: "",
            isActive: controller.blogInfo.value?.isSaved ?? false,
            onTap: () => controller.toggleSaved(controller.blogInfo.value!),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaGrid() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MetaItem(
                icon: Icons.calendar_today_outlined,
                title: 'Publication Date',
                value: controller.blogInfo.value?.createdAt.toString() ?? '',
              ),
            ),
            Expanded(
              child: MetaItem(
                icon: Icons.sell_outlined,
                title: 'Tags',
                value:
                    controller.blogInfo.value?.tags
                        .map((tag) => tag.name)
                        .join(', ') ??
                    '',
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.hp(0.024)),
        Container(height: 1, color: Appcolor.panelEdge),
        SizedBox(height: Responsive.hp(0.024)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MetaItem(
                icon: Icons.timer_outlined,
                title: 'Reading Time',
                value: controller.blogInfo.value?.readingTime ?? '',
              ),
            ),
            Expanded(
              child: MetaItem(
                icon: Icons.person_outline,
                title: 'Author Name',
                value: controller.blogInfo.value?.user.name ?? '',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.06)),
        child: Container(
          padding: EdgeInsets.all(Responsive.wp(0.055)),
          decoration: BoxDecoration(
            color: Appcolor.panel,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Appcolor.panelEdge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Responsive.wp(0.16),
                height: Responsive.wp(0.16),
                decoration: const BoxDecoration(
                  color: Color(0x1FE05C5C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Appcolor.danger,
                  size: 32,
                ),
              ),
              SizedBox(height: Responsive.hp(0.02)),
              CustomText(
                text: "Delete this post?",
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.05),
                fontWeight: FontWeight.w700,
                textColor: Appcolor.white,
              ),
              SizedBox(height: Responsive.hp(0.01)),
              CustomText(
                text: "This action is permanent and cannot be undone.",
                styleType: TextStyleType.BODY,
                textColor: Appcolor.muted,
              ),
              SizedBox(height: Responsive.hp(0.028)),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.hp(0.015),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Appcolor.panelEdge),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Cancel",
                          styleType: TextStyleType.SMALL,
                          fontWeight: FontWeight.w600,
                          textColor: Appcolor.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.wp(0.03)),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Get.back();
                        controller.deleteBlog(controller.blogInfo.value!);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.hp(0.015),
                        ),
                        decoration: BoxDecoration(
                          color: Appcolor.danger,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Delete",
                          styleType: TextStyleType.SMALL,
                          fontWeight: FontWeight.w600,
                          textColor: Appcolor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: Responsive.wp(0.09),
          height: Responsive.wp(0.09),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Appcolor.panel,
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Icon(icon, color: color, size: Responsive.sp(0.042)),
        ),
      ),
    );
  }
}
