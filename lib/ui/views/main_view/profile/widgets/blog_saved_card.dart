import 'package:flutter/material.dart';
import 'package:teck_talk/core/data/responses/saved_item_response.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/custom_widget/tag_widget.dart';
import 'package:teck_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class BlogSavedCard extends StatelessWidget {
  final BlogListSavedModel blog;

  const BlogSavedCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsetsDirectional.only(
          top: screenWidth(50),
          start: screenWidth(55),
          end: screenWidth(20),
        ),
        padding: EdgeInsetsDirectional.only(bottom: screenWidth(20)),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Appcolor.gray_60.withAlpha(150),
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenWidth(1.8),
              child: Image.asset(
                blog.coverImageUrl ?? "assets/images/png/blog_image.png",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            //* tags
            Wrap(
              spacing: 8,
              children: [
                "flutter",
                "Front End",
              ].map((e) => TagWidget(text: e)).toList(),
            ),
            CustomText(
              text: blog.title,
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(19),
              fontWeight: FontWeight.w600,
              textColor: Appcolor.white,
            ),
            CustomText(
              text: blog.subtitle,
              styleType: TextStyleType.BODY,
              textColor: Appcolor.white,
            ),
            SizedBox(height: screenWidth(40)),
            UsetInfoHeader(
              nameProfile: blog.user.name,
              date: blog.createdAt,
              imageProfile: blog.user.avatarUrl,
            ),
          ],
        ),
      ),
    );
  }
}
