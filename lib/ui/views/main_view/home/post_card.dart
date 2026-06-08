import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/homecontroller.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart'
    show CustomText, TextStyleType;
import 'package:tech_talk/ui/shared/custom_widget/tag_widget.dart';
import 'package:tech_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:tech_talk/ui/shared/dialogs/code_dialog.dart';
import 'package:tech_talk/ui/shared/shared_widget/NumberFormatter.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart'
    show screenWidth;
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/views/code_view/code_view.dart';

class PostCard extends GetView<Homecontroller> {
  final PostSavedModel post;
  final VoidCallback onFavorite;
  final VoidCallback onComment;
  final VoidCallback onSaved;

  PostCard({
    super.key,
    required this.post,
    required this.onFavorite,
    required this.onComment,
    required this.onSaved,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenWidth(50)),
      padding: EdgeInsets.all(screenWidth(40)),
      decoration: BoxDecoration(
        color: Appcolor.dark_20.withAlpha(90),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Appcolor.dark_20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*  header user info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: UsetInfoHeader(
                  nameProfile: post.user.name,
                  date: post.createdAt,
                  imageProfile: post.user.avatarUrl,
                ),
              ),

              // //*  code view
              if (post.code != null && post.code!.isNotEmpty)
                ViewCodeButton(post.code, post.codeLanguage),
            ],
          ),
          //*  text post
          Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(top: screenWidth(40)),
            padding: EdgeInsetsDirectional.all(screenWidth(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: post.title,
                  styleType: TextStyleType.CUSTOM,
                  fontSize: screenWidth(19),
                  textColor: Appcolor.white.withAlpha(200),
                ),
                CustomText(
                  text: post.body,
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.white.withAlpha(200),
                ),
              ],
            ),
          ),

          //*  tags
          if (post.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              children: post.tags.map((e) => TagWidget(text: e.name)).toList(),
            ),

          //*  post images
          if (post.photos.isNotEmpty)
            SizedBox(
              height: screenWidth(1.8),
              child: PageView.builder(
                itemCount: post.photos.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: post.photos[index].url,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                numOfInteractors: NumberFormatter.format(post.likesCount),
                color: Appcolor.red,
                isActive: post.isLikedByUser,
                function: onFavorite,
              ),
              ActiveIcon(
                icon: Icon(Icons.comment_bank_outlined),
                iconIsActive: Icon(Icons.comment_bank_outlined),
                numOfInteractors: NumberFormatter.format(post.commentsCount),
                color: Appcolor.white.withAlpha(150),
                isActive: true,
                function: onComment,
              ),
              ActiveIcon(
                icon: Icon(Icons.bookmark_border),
                iconIsActive: Icon(Icons.bookmark),
                numOfInteractors: null,
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
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(100),
        vertical: screenWidth(50),
      ),
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
