import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/childreen_comments_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/comment_card.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/comments/widgets/send_box_comment.dart';

class ChildreenComments extends GetView<ChildreenCommentsController> {
  const ChildreenComments({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Padding(
          padding: EdgeInsetsDirectional.only(
            top: Responsive.hp(0.02),
            start: Responsive.wp(0.02),
            end: Responsive.wp(0.02),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentCard(
                comment: controller.comment,
                ischild: true,
                isReply: false,
                likeCallback: () => controller.toggleLike(controller.comment),
                dislikeCallback: () =>
                    controller.toggleDislike(controller.comment),
                replies: () {},
              ),
              Container(
                height: 2,
                color: Appcolor.accent.withAlpha(50),
                margin: EdgeInsets.symmetric(
                  vertical: Responsive.hp(0.01),
                  horizontal: Responsive.wp(0.02),
                ),
              ),
              CustomText(
                text: "Replies :",
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.05),
                fontWeight: FontWeight.bold,
                textColor: Appcolor.accent.withAlpha(200),
              ),

              Expanded(
                child: Obx(
                  () => ListView(
                    children: [
                      SizedBox(height: Responsive.hp(0.03)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.childremComments.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CommentCard(
                                comment: controller.childremComments[index],
                                likeCallback: () => controller.toggleLike(
                                  controller.childremComments[index],
                                ),
                                dislikeCallback: () => controller.toggleDislike(
                                  controller.childremComments[index],
                                ),
                                replies: () {},
                                isReply: false,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SendBoxComment(
                onSend: () => controller.commentPost(controller.comment),
                typeController: controller.typeController,
                codeController: controller.codeController,
                mentionUsers: controller.mentionUsers,
                showMentionList: controller.showMentionList,
                onMentionTap: controller.selectMentionUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
