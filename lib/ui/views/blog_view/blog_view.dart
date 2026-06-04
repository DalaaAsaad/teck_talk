import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/blog_view_controller.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/blog_view/widgets/blog_view_header.dart';
import 'package:teck_talk/ui/views/blog_view/widgets/content_preview.dart';
import 'package:teck_talk/ui/views/blog_view/widgets/meta_item.dart';
import 'package:teck_talk/ui/views/blog_view/widgets/metric_chip.dart';
import 'package:teck_talk/ui/views/blog_view/widgets/table_of_contents_card.dart';

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
              BlogViewHeader(
                heroImage: controller.heroImage,
                title: controller.title,
                subTitle: controller.subTitle,
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
                        tableOfContents: controller.tableOfContents,
                      ),
                      SizedBox(height: screenWidth(24)),
                      ContentPreview(
                        tableOfContents: controller.tableOfContents,
                        contentMap: controller.contentMap,
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
            icon: controller.isFavorite.value
                ? Icons.favorite
                : Icons.favorite_border,
            iconColor: Colors.deepOrangeAccent,
            label: controller.formatEngagement(controller.engagement['likes']),
            onTap: controller.toggleFavorite,
          ),
          SizedBox(width: screenWidth(34)),
          MetricChip(
            icon: Icons.visibility_outlined,
            iconColor: Appcolor.white,
            label: controller.formatEngagement(controller.engagement['views']),
          ),
          SizedBox(width: screenWidth(34)),
          MetricChip(
            icon: controller.isSaved.value
                ? Icons.bookmark
                : Icons.bookmark_border_rounded,
            iconColor: Appcolor.white,
            label: controller.formatEngagement(
              controller.engagement['bookmarks'],
            ),
            onTap: controller.toggleSaved,
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
                value: controller.metadata['Publication Date'] ?? '',
              ),
            ),
            Expanded(
              child: MetaItem(
                title: 'Category',
                value: controller.metadata['Category'] ?? '',
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
                value: controller.metadata['Reading Time'] ?? '',
              ),
            ),
            Expanded(
              child: MetaItem(
                title: 'Author Name',
                value: controller.metadata['Author Name'] ?? '',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
