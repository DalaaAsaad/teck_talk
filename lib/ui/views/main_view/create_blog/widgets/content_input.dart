import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/create_blog_controller.dart';

class ContentInput extends GetView<CreateBlogController> {
  const ContentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.contentController,
      maxLines: 4,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: "What's on your mind?\nShare a problem, idea, or question...",
        hintStyle: TextStyle(color: Appcolor.gray_60),
        border: InputBorder.none,
      ),
    );
  }
}
