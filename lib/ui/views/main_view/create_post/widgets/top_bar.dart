import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';

class TopBar extends GetView<CreatePostController> {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomText(
          text: "Create Post",
          styleType: TextStyleType.BODY,
          textColor: Appcolor.yellow_70.withAlpha(180),
        ),
        Spacer(),
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
