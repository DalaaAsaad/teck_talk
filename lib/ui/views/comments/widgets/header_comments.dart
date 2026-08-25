import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/comments_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class HeaderComments extends GetView<CommentsController> {
  const HeaderComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: Responsive.hp(0.03),
        start: Responsive.wp(0.04),
        end: Responsive.wp(0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.wp(0.04),
                    vertical: Responsive.hp(0.005),
                  ),
                  decoration: BoxDecoration(
                    color: Appcolor.accent,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Appcolor.accent.withAlpha(100),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CustomText(
                    text: controller.comments.length.toString(),
                    styleType: TextStyleType.CUSTOM,
                    fontSize: Responsive.sp(0.06),
                    textColor: Appcolor.white,
                  ),
                ),
              ),
              CustomText(
                text: "     //....  Comments",
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.05),
                textColor: Appcolor.white.withAlpha(150),
              ),
            ],
          ),
   
        ],
      ),
    );
  }
}
