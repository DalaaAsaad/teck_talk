import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/comments_controller.dart';
import 'package:tech_talk/ui/views/comments/widgets/body_comments.dart';
import 'package:tech_talk/ui/views/comments/widgets/header_comments.dart';
import 'package:tech_talk/ui/views/comments/widgets/send_box_comment.dart';

class Comments extends GetView<CommentsController> {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Column(
          children: [
            HeaderComments(),
            BodyComments(),
            SendBoxComment(
              onSend: controller.commentPost,
              typeController: controller.typeController,
              codeController: controller.codeController,
              mentionUsers: controller.mentionUsers,
              showMentionList: controller.showMentionList,
              onMentionTap: controller.selectMentionUser,
            ),
          ],
        ),
      ),
    );
  }
}
