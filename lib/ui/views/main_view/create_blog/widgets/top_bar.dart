import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/create_blog_controller.dart';

class TopBar extends GetView<CreateBlogController> {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: controller.onCancel,
          child: CustomText(
            text: "Cancel",
            styleType: TextStyleType.BODY,
            textColor: Appcolor.white.withAlpha(180),
          ),
        ),
      ],
    );
  }
}
