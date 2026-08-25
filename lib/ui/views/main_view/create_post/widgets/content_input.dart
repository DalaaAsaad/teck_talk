import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';

class ContentInput extends GetView<CreatePostController> {
  const ContentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller.titleController,
          maxLines: 1,
          style: TextStyle(
            color: Appcolor.white,
            fontSize: Responsive.sp(0.045),
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(color: Appcolor.muted),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: Responsive.hp(0.008),
            ),
          ),
        ),
        SizedBox(height: Responsive.hp(0.008)),
        TextField(
          controller: controller.contentController,
          maxLines: 4,
          style: TextStyle(
            color: Appcolor.white.withOpacity(0.9),
            fontSize: Responsive.sp(0.037),
          ),
          decoration: InputDecoration(
            hintText:
                "What's on your mind?\nShare a problem, idea, or question...",
            hintStyle: TextStyle(color: Appcolor.muted),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}