import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/comments_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/comment_card.dart';

class BodyComments extends GetView<CommentsController> {
  const BodyComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView(
          children: [
            SizedBox(height: Responsive.hp(0.02)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.comments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CommentCard(
                      comment: controller.comments[index],
                      isPostOwner: controller.isPostOwner.value,
                      onPinToggle: () {
                        controller.togglePinComment(controller.comments[index]);
                      },
                      likeCallback: () =>
                          controller.toggleLike(controller.comments[index]),
                      dislikeCallback: () =>
                          controller.toggleDislike(controller.comments[index]),
                      replies: () {
                        Get.toNamed(
                          AppRoutes.childreenComments,
                          arguments: controller.comments[index],
                        );
                      },
                      isCommentOwner:
                          controller.comments[index].userId ==
                          controller.userId,
                      onDelete: () =>
                          controller.toggleDelete(controller.comments[index]),
                      onEdit: () {},
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
