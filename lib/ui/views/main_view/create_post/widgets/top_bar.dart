import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';

class TopBar extends GetView<CreatePostController> {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: "Create Post",
          styleType: TextStyleType.CUSTOM,
          fontSize: Responsive.sp(0.05),
          fontWeight: FontWeight.w700,
          textColor: Appcolor.white,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: controller.resetForm,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.032),
              vertical: Responsive.hp(0.008),
            ),
            decoration: BoxDecoration(
              color: Appcolor.panel,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Appcolor.panelEdge),
            ),
            child: CustomText(
              text: "Cancel",
              styleType: TextStyleType.BODY,
              textColor: Appcolor.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
