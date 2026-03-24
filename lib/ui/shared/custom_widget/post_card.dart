import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:teck_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart'
    show CustomText, TextStyleType;
import 'package:teck_talk/ui/shared/custom_widget/text_post.dart';
import 'package:teck_talk/ui/shared/custom_widget/user_info.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart'
    show screenWidth;
import 'package:teck_talk/ui/views/main_view/home/homecontroller.dart';

class PostCard extends StatelessWidget {
  final Homecontroller controller;
  final String nameProfile;
  final String history;
  final Callback onTap;
  final String textPost;
  final String numfav;
  final String numComment;
  final String numSaved;

  const PostCard({
    super.key,
    required this.controller,
    required this.nameProfile,
    required this.history,
    required this.onTap,
    required this.textPost,
    required this.numfav,
    required this.numComment,
    required this.numSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: screenWidth(20),
        start: screenWidth(55),
        end: screenWidth(20),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withAlpha(100), width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              UserInfo(
                nameProfile: nameProfile,
                history: history,
                imagePath: "assets/images/png/profile.png",
              ),
              InkWell(
                splashColor: Appcolor.yellow_70,
                onTap: onTap,
                child: Container(
                  height: screenWidth(7.5),
                  width: screenWidth(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Appcolor.white.withAlpha(150),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "View Code ",
                          styleType: TextStyleType.BODY,
                          textColor: Appcolor.white.withAlpha(150),
                        ),
                        Icon(
                          Icons.arrow_outward_rounded,
                          color: Appcolor.yellow_70.withAlpha(200),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextPost(textPost: textPost),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/png/imageTest.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              ActiveIcon(
                icon: Icon(Icons.favorite_border),
                iconIsActive: Icon(Icons.favorite),
                numOfInteractors: numfav,
                color: Appcolor.red,
                isActive: controller.isFavorit,
                function: controller.toggleFavorite,
              ),
              ActiveIcon(
                icon: Icon(Icons.comment_bank_outlined),
                iconIsActive: Icon(Icons.comment_bank_outlined),
                numOfInteractors: numComment,
                color: Appcolor.white.withAlpha(150),
                isActive: controller.isComment,
                function: controller.toggleComment,
              ),
              ActiveIcon(
                icon: Icon(Icons.bookmark_border),
                iconIsActive: Icon(Icons.bookmark),
                numOfInteractors: numSaved,
                color: Appcolor.white.withAlpha(150),
                isActive: controller.isSaved,
                function: controller.toggleSaved,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
