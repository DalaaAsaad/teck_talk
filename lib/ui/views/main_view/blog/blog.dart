import 'package:flutter/material.dart';
import 'package:teck_talk/core/data/models/blog_model.dart';
import 'package:teck_talk/ui/views/main_view/blog/blog_card.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  List<BlogModel> Blogs = [
    BlogModel(
      nameProfile: "Hassan Ahmad",
      imageProfile: "assets/images/png/profile.png",
      date: '2 day',
      titleBlog: "Docker for Beginners: Stop Struggling ",
      textBlog:
          "A step-by-step guide to containerize your first application without the headache...",
      tags: ["Front End", "Problem"],
      imageBlog: "assets/images/png/blog_image.png",
    ),
    BlogModel(
      nameProfile: "Hassan Ahmad",
      imageProfile: "assets/images/png/profile.png",
      date: '2 day',
      titleBlog: "Docker for Beginners: Stop Struggling ",
      textBlog:
          "A step-by-step guide to containerize your first application without the headache...",
      tags: ["Front End", "Problem"],
      imageBlog: "assets/images/png/blog_image.png",
    ),
    BlogModel(
      nameProfile: "Hassan Ahmad",
      imageProfile: "assets/images/png/profile.png",
      date: '2 day',
      titleBlog: "Docker for Beginners: Stop Struggling ",
      textBlog:
          "A step-by-step guide to containerize your first application without the headache...",
      tags: ["Front End", "Problem"],
      imageBlog: "assets/images/png/blog_image.png",
    ),
    BlogModel(
      nameProfile: "Hassan Ahmad",
      imageProfile: "assets/images/png/profile.png",
      date: '2 day',
      titleBlog: "Docker for Beginners: Stop Struggling ",
      textBlog:
          "A step-by-step guide to containerize your first application without the headache...",
      tags: ["Front End", "Problem"],
      imageBlog: "assets/images/png/blog_image.png",
    ),
    BlogModel(
      nameProfile: "Hassan Ahmad",
      imageProfile: "assets/images/png/profile.png",
      date: '2 day',
      titleBlog: "Docker for Beginners: Stop Struggling ",
      textBlog:
          "A step-by-step guide to containerize your first application without the headache...",
      tags: ["Front End", "Problem"],
      imageBlog: "assets/images/png/blog_image.png",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolor.black_08,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Blogs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: BlogCard(blog: Blogs[index]),
              );
            },
          ),
          SizedBox(height: screenWidth(5)),
        ],
      ),
    );
  }
}
