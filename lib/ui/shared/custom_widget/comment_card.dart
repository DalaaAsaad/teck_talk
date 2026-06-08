import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:tech_talk/ui/views/code_view/code_view.dart';

import 'package:tech_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/controllers/comments_controller.dart';

class CommentCard extends GetView<CommentsController> {
  final CommentModel comment;
  final bool? ischild;
  const CommentCard({super.key, required this.comment, this.ischild = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenWidth(60)),
      child: Column(
        children: [
          UsetInfoHeader(
            nameProfile: comment.userName,
            date: comment.createdAt,
            imageProfile: comment.avatarUrl,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(top: screenWidth(41)),
            padding: EdgeInsetsDirectional.all(screenWidth(41)),
            child: CustomText(
              text: comment.body,
              styleType: TextStyleType.BODY,
              textColor: Appcolor.white.withAlpha(200),
            ),
          ),

          if (comment.code != null && comment.code!.trim().isNotEmpty)
            CodeView(
              mode: CodeViewMode.view,
              isdialog: false,
              code: comment.code,
            ),

          Row(
            children: [
              if (ischild == false) ...[
                ActiveIcon(
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  iconIsActive: Icon(Icons.thumb_up),
                  numOfInteractors: controller.formatEngagement(
                    int.parse(comment.likesCount),
                  ),
                  color: Appcolor.white.withAlpha(200),
                  isActive: comment.isLikedByUser,
                  function: () => controller.toggleLike(comment),
                ),
                SizedBox(width: screenWidth(20)),
                ActiveIcon(
                  icon: Icon(Icons.thumb_down_alt_outlined),
                  iconIsActive: Icon(Icons.thumb_down),
                  numOfInteractors: controller.formatEngagement(
                    int.parse(comment.dislikesCount),
                  ),
                  color: Appcolor.white.withAlpha(200),
                  isActive: comment.isDislikedByUser,
                  function: () => controller.toggleDislike(comment),
                ),
                SizedBox(width: screenWidth(20)),
              ],

              InkWell(
                onTap: () {
                  // Handle reply action
                },
                child: CustomText(
                  text: "Reply",
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.white.withAlpha(200),
                ),
              ),

              Spacer(),

              if (comment.hasChildrens && ischild != true)
                InkWell(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.childreenComments,
                      arguments: comment,
                    );
                  },
                  child: CustomText(
                    text: "show Replies",
                    styleType: TextStyleType.BODY,
                    textColor: Appcolor.yellow_70.withAlpha(200),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
