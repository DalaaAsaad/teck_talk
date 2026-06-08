import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/comments_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class HeaderComments extends GetView<CommentsController> {
  const HeaderComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: screenWidth(15),
        start: screenWidth(20),
        end: screenWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(
                () => CustomText(
                  text: controller.comments.length.toString(),
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.white.withAlpha(150),
                ),
              ),
              CustomText(
                text: "   Comments",
                styleType: TextStyleType.BODY,
                textColor: Appcolor.white.withAlpha(150),
              ),
            ],
          ),
          // ActiveIcon(
          //   icon: Icon(Icons.favorite_border),
          //   iconIsActive: Icon(Icons.favorite),
          //   numOfInteractors: controller.formatEngagement(
          //     controller.likesCount,
          //   ),
          //   color: Appcolor.red,
          //   isActive: controller.isLikedByUser,
          //   function: () {},
          // ),
        ],
      ),
    );
  }
}
