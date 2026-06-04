import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/controllers/create_post_controller.dart';

class ContentInput extends GetView<CreatePostController> {
  const ContentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller.titleController,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
          decoration: const InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(color: Color.fromARGB(255, 186, 186, 191)),
            border: InputBorder.none,
          ),
        ),
        TextField(
          controller: controller.contentController,
          maxLines: 4,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText:
                "What's on your mind?\nShare a problem, idea, or question...",
            hintStyle: TextStyle(color: Appcolor.gray_60),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
