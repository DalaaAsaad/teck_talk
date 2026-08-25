import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/custom_widget/blog_card.dart';

class BlogTab extends GetView<Search_Controller> {
  const BlogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final blogs = controller.blogs;

      // =========================
      // No blogs found
      // =========================
      if (!controller.isLoading.value &&
          blogs.isEmpty &&
          controller.isSearching) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.08)),
            child: CustomText(
              text: 'No blogs found for this search',
              styleType: TextStyleType.BODY,
              textColor: Appcolor.muted,
              fontSize: Responsive.sp(0.038),
            ),
          ),
        );
      }

      // =========================
      // Blogs list
      // =========================
      return ListView.builder(
        padding: EdgeInsets.only(
          top: Responsive.hp(0.01),
          bottom: Responsive.hp(0.02),
        ),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return BlogCard(
            title: controller.blogs[index].title,
            subtitle: controller.blogs[index].subtitle,
            coverImageUrl: controller.blogs[index].coverImageUrl,
            tags: const [],
            authorName: controller.blogs[index].user.name,
            authorAvatarUrl: "assets/images/png/profile.png",
            createdAt: controller.blogs[index].createdAt,
            onReadMore: () {
              Get.toNamed(
                AppRoutes.blogView,
                arguments: controller.blogs[index].id,
              );
            },
          );
        },
      );
    });
  }
}
