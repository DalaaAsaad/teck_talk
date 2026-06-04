import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/search_controller.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/blog/blog_card.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/blog_card_search.dart';

class BlogTab extends GetView<Search_Controller> {
  const BlogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final blogs = controller.blogs;

      // Show "No blogs found" only after loading completes and blogs are empty
      if (!controller.isLoading.value &&
          blogs.isEmpty &&
          controller.isSearching) {
        return Center(
          child: CustomText(
            text: 'No blogs found for this search',
            styleType: TextStyleType.BODY,
            textColor: Appcolor.gray_60,
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.only(top: screenWidth(30), bottom: screenWidth(5)),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return BlogCardSearch(blog: blogs[index]);
        },
      );
    });
  }
}
