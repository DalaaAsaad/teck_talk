import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/core/models/post_model.dart';
import 'package:teck_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart'
    show CustomText, TextStyleType;
import 'package:teck_talk/ui/shared/custom_widget/tag_widget.dart';
import 'package:teck_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:teck_talk/ui/shared/dialogs/code_dialog.dart';
import 'package:teck_talk/ui/shared/shared_widget/NumberFormatter.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart'
    show screenWidth;
import 'package:teck_talk/ui/views/code_view/code_model.dart';
import 'package:teck_talk/ui/views/code_view/code_view.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onFavorite;
  final VoidCallback onComment;
  final VoidCallback onSaved;

  const PostCard({
    super.key,
    required this.post,
    required this.onFavorite,
    required this.onComment,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: screenWidth(20),
        start: screenWidth(20),
        end: screenWidth(20),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Appcolor.gray_60.withAlpha(150), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*  header user info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UsetInfoHeader(
                nameProfile: post.nameProfile,
                date: post.date,
                imageProfile: post.imageProfile,
              ),

              //*  code view
              if (post.code != null && post.code!.isNotEmpty)
                ViewCodeButton(post.code, post.codeLanguage),
            ],
          ),
          //*  text post
          Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(top: screenWidth(40)),
            padding: EdgeInsetsDirectional.all(screenWidth(40)),
            child: CustomText(
              text: post.textPost,
              styleType: TextStyleType.BODY,
              textColor: Appcolor.white.withAlpha(200),
            ),
          ),

          //*  tags
          Wrap(
            spacing: 8,
            children: post.tags.map((e) => TagWidget(text: e)).toList(),
          ),
          //*  post images
          if (post.images != null && post.images!.isNotEmpty)
            SizedBox(
              height: screenWidth(1.8),
              child: PageView.builder(
                itemCount: post.images!.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    post.images![index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          //* active icon for post
          Row(
            children: [
              ActiveIcon(
                icon: Icon(Icons.favorite_border),
                iconIsActive: Icon(Icons.favorite),
                numOfInteractors: NumberFormatter.format(post.numFav),
                color: Appcolor.red,
                isActive: post.isFavorite,
                function: onFavorite,
              ),
              ActiveIcon(
                icon: Icon(Icons.comment_bank_outlined),
                iconIsActive: Icon(Icons.comment_bank_outlined),
                numOfInteractors: NumberFormatter.format(post.numComment),
                color: Appcolor.white.withAlpha(150),
                isActive: post.isComment,
                function: onComment,
              ),
              ActiveIcon(
                icon: Icon(Icons.bookmark_border),
                iconIsActive: Icon(Icons.bookmark),
                numOfInteractors: NumberFormatter.format(post.numSaved),
                color: Appcolor.white.withAlpha(150),
                isActive: post.isSaved,
                function: onSaved,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget ViewCodeButton(String? code, String? languageCode) {
  return InkWell(
    splashColor: Appcolor.yellow_70,
    onTap: () {
      Get.dialog(
        CodeDialog(
          codeView: CodeView(
            code: code,
            mode: CodeViewMode.view,
            isdialog: true,
            languageCode: languageCode,
          ),
        ),
      );
    },
    child: Container(
      height: screenWidth(7.7),
      width: screenWidth(3.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: Appcolor.gray_60),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "View Code ",
              styleType: TextStyleType.SMALL,
              textColor: Appcolor.gray_60,
            ),
            Icon(
              Icons.arrow_outward_rounded,
              color: Appcolor.yellow_70.withAlpha(200),
            ),
          ],
        ),
      ),
    ),
  );
}
