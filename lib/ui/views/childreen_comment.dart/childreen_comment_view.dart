import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/childreen_comments_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/comment_card.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class ChildreenComments extends GetView<ChildreenCommentsController> {
  const ChildreenComments({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Padding(
          padding: EdgeInsetsDirectional.only(
            top: screenWidth(40),
            start: screenWidth(30),
            end: screenWidth(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentCard(comment: controller.comment, ischild: true),
              Container(
                height: 1,
                color: Appcolor.white.withAlpha(50),
                margin: EdgeInsets.symmetric(
                  vertical: screenWidth(100),
                  horizontal: screenWidth(20),
                ),
              ),
              CustomText(
                text: "Replies :",
                styleType: TextStyleType.CUSTOM,
                fontSize: screenWidth(20),
                fontWeight: FontWeight.bold,
                textColor: Appcolor.yellow_70.withAlpha(200),
              ),
              Expanded(
                child: Obx(
                  () => ListView(
                    children: [
                      SizedBox(height: screenWidth(100)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.childremComments.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CommentCard(
                                comment: controller.childremComments[index],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
