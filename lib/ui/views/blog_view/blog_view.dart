import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/blog_view_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/blog_view_header.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/content_preview.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/meta_item.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/metric_chip.dart';
import 'package:tech_talk/ui/views/blog_view/widgets/table_of_contents_card.dart';

class BlogView extends GetView<BlogViewController> {
  const BlogView({super.key});
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = screenWidth(18);

    return Scaffold(
      backgroundColor: Appcolor.black_08,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => BlogViewHeader(
                  heroImage:
                      controller.blogInfo.value?.coverImageUrl ??
                      "assets/images/png/blog_image.png",
                  title: controller.blogInfo.value?.title ?? '',
                  subTitle: controller.blogInfo.value?.subtitle ?? '',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 1,
                        color: Appcolor.dark_20.withAlpha(140),
                      ),
                      SizedBox(height: screenWidth(24)),
                      _buildEngagementRow(),
                      SizedBox(height: screenWidth(24)),
                      Container(
                        height: 1,
                        color: Appcolor.dark_20.withAlpha(140),
                      ),
                      SizedBox(height: screenWidth(24)),
                      _buildMetaGrid(),
                      SizedBox(height: screenWidth(28)),
                      CustomText(
                        text: 'Table of Contents',
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.gray_60,
                        fontSize: screenWidth(20),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: screenWidth(20)),
                      TableOfContentsCard(
                        tableOfContents:
                            controller.blogInfo.value?.sections
                                .map((section) => section.title)
                                .toList() ??
                            <String>[],
                      ),
                      SizedBox(height: screenWidth(24)),
                      ContentPreview(
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

                      SizedBox(height: screenWidth(22)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEngagementRow() {
    return Obx(
      () => Row(
        children: [
          MetricChip(
            icon: controller.blogInfo.value?.isLikedByUser == true
                ? Icons.favorite
                : Icons.favorite_border,
            iconColor: Colors.deepOrangeAccent,
            label: controller.formatEngagement(
              controller.blogInfo.value?.likesCount,
            ),
            onTap: () => controller.toggleFavorite(controller.blogInfo.value!),
          ),
          SizedBox(width: screenWidth(34)),
          MetricChip(
            icon: Icons.visibility_outlined,
            iconColor: Appcolor.white,
            label: controller.formatEngagement(
              controller.blogInfo.value?.viewsCount,
            ),
          ),
          SizedBox(width: screenWidth(34)),
          MetricChip(
            icon: controller.blogInfo.value?.isSaved == true
                ? Icons.bookmark
                : Icons.bookmark_border_rounded,
            iconColor: Appcolor.white,
            label: "",
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
                title: 'Publication Date',
                value: controller.blogInfo.value?.createdAt.toString() ?? '',
              ),
            ),
            Expanded(
              child: MetaItem(
                title: 'Category',
                value:
                    controller.blogInfo.value?.sections
                        .map((s) => s.title)
                        .join(', ') ??
                    '',
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth(22)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MetaItem(
                title: 'Reading Time',
                value: controller.blogInfo.value?.readingTime.toString() ?? '',
              ),
            ),
            Expanded(
              child: MetaItem(
                title: 'Author Name',
                value: controller.blogInfo.value?.user.name ?? '',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
