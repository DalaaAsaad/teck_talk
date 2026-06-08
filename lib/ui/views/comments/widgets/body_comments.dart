import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/comments_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/comment_card.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class BodyComments extends GetView<CommentsController> {
  const BodyComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView(
          children: [
            SizedBox(height: screenWidth(100)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.comments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CommentCard(comment: controller.comments[index]),
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
