import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:teck_talk/core/models/post_model.dart';
import 'package:teck_talk/ui/shared/custom_widget/iconwithtitle.dart';
import 'package:teck_talk/ui/views/compiler/compiler.dart';
import 'package:teck_talk/ui/views/main_view/home/post_card.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/controllers/homecontroller.dart';
import 'package:teck_talk/ui/views/roadmaps/roadmaps.dart';
import 'package:teck_talk/ui/views/uml_design/uml_design.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Homecontroller controller = Get.find();

  List<PostModel> posts = [
    PostModel(
      imageProfile: "assets/images/png/profile.png",

      nameProfile: "Ahmad Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["front End", "back End"],
      images: [
        "assets/images/png/imageTest.png",
        "assets/images/png/blog_image.png",
      ],
    ),
    PostModel(
      imageProfile: "assets/images/png/profile.png",

      nameProfile: "Ahmad Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["front End", "back End"],
      images: [],
    ),
    PostModel(
      imageProfile: "assets/images/png/profile.png",

      nameProfile: "Ahmad Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["front End", "back End"],
      images: [
        "assets/images/png/imageTest.png",
        "assets/images/png/blog_image.png",
      ],
      code: """public class Main {
    public static void main(String[] args) {
        // طباعة رسالة ترحيبية
        System.out.println("مرحبا بك في برنامج الحساب!");

        // تعريف رقمين
        int a = 5;
        int b = 7;

        // حساب المجموع
        int sum = a + b;

        // عرض النتيجة
        System.out.println("مجموع " + a + " و " + b + " = " + sum);
    }
}""",
      codeLanguage: "java",
    ),
    PostModel(
      imageProfile: "assets/images/png/profile.png",

      nameProfile: "Ahmad Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["front End", "back End"],
      images: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black_08,
      floatingActionButton: Padding(
        padding: EdgeInsetsDirectional.only(bottom: screenWidth(5)),
        child: SpeedDial(
          foregroundColor: Appcolor.black_08,
          overlayColor: Appcolor.black_08,
          overlayOpacity: 0.6,
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: Appcolor.yellow_70,
          children: [
            SpeedDialChild(
              backgroundColor: Appcolor.yellow_70,
              child: Image.asset("assets/images/png/chatBot.png"),
            ),
            SpeedDialChild(
              backgroundColor: Appcolor.yellow_70,
              child: IconWithTitle(
                svgPath: "assets/images/svg/compilerIcon.svg",
                // title: "code Compiler",
                onTap: () {
                  Get.to(() => Compiler());
                },
              ),
            ),

            SpeedDialChild(
              backgroundColor: Appcolor.yellow_70,
              child: IconWithTitle(
                svgPath: "assets/images/svg/roadmapIcon.svg",
                onTap: () {
                  Get.to(Roadmaps());
                },
              ),
            ),
            SpeedDialChild(
              backgroundColor: Appcolor.yellow_70,
              child: IconWithTitle(
                svgPath: "assets/images/svg/umlIcon.svg",
                onTap: () {
                  Get.to(UmlDesign());
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Appcolor.black_08,
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: screenWidth(6)),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(
              post: posts[index],
              onFavorite: () => controller.toggleFavorite(posts[index]),

              onComment: () => controller.toggleComment(posts[index]),

              onSaved: () => controller.toggleSaved(posts[index]),
            );
          },
        ),
      ),
    );
  }
}
