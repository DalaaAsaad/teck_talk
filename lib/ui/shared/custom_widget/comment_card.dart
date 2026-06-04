import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/views/code_view/code_model.dart';
import 'package:teck_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:teck_talk/ui/views/code_view/code_view.dart';

import 'package:teck_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/comments/comments_controller.dart';

class CommentCard extends StatelessWidget {
  final CommentsController controller;
  final String nameProfile;
  final String numFavorite;
  final String numComments;
  final String numLikes;
  final String numDislikes;
  final String history;
  final String imagePath;
  final String textcomment;
  final String? code;
  CommentCard({
    super.key,
    required this.controller,
    this.code,
    required this.numFavorite,
    required this.numLikes,
    required this.numDislikes,
    required this.history,
    required this.imagePath,
    required this.textcomment,
    required this.nameProfile,
    required this.numComments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenWidth(60)),
      child: Column(
        children: [
          UsetInfoHeader(
            nameProfile: nameProfile,
            date: history,
            imageProfile: imagePath,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(top: screenWidth(41)),
            padding: EdgeInsetsDirectional.all(screenWidth(41)),
            child: CustomText(
              text: textcomment,
              styleType: TextStyleType.BODY,
              textColor: Appcolor.white.withAlpha(200),
            ),
          ),

          if (code != null && code!.trim().isNotEmpty)
            CodeView(mode: CodeViewMode.view, isdialog: false, code: code),

          Row(
            children: [
              ActiveIcon(
                icon: Icon(Icons.thumb_up_alt_outlined),
                iconIsActive: Icon(Icons.thumb_up),
                numOfInteractors: numLikes,
                color: Appcolor.white.withAlpha(200),
                isActive: true,
                function: controller.toggleLike,
              ),
              SizedBox(width: screenWidth(20)),
              ActiveIcon(
                icon: Icon(Icons.thumb_down_alt_outlined),
                iconIsActive: Icon(Icons.thumb_down),
                numOfInteractors: numDislikes,
                color: Appcolor.white.withAlpha(200),
                isActive: true,
                function: controller.toggleDislike,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
