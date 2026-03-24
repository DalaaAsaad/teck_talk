import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/views/main_view/code_view/code_model.dart';
import 'package:teck_talk/ui/views/main_view/code_view/code_view.dart';
import 'package:teck_talk/ui/shared/custom_widget/iconwithtitle.dart';
import 'package:teck_talk/ui/shared/custom_widget/post_card.dart' show PostCard;

import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/compiler/compiler.dart';
import 'package:teck_talk/ui/shared/dialogs/code_dialog.dart';

import 'package:teck_talk/ui/views/main_view/home/homecontroller.dart';
import 'package:teck_talk/ui/views/roadmaps/roadmaps.dart';
import 'package:teck_talk/ui/views/uml_design/uml_design.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Homecontroller controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolor.black_08,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: screenWidth(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconWithTitle(
                svgPath: "assets/images/svg/compilerIcon.svg",
                title: "code Compiler",
                onTap: () {
                  Get.to(() => Compiler());
                },
              ),
              IconWithTitle(
                svgPath: "assets/images/svg/roadmapIcon.svg",
                title: "Roadmaps",
                onTap: () {
                  Get.to(Roadmaps());
                },
              ),
              IconWithTitle(
                svgPath: "assets/images/svg/umlIcon.svg",
                title: "UML Designer",
                onTap: () {
                  Get.to(UmlDesign());
                },
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth(20),
              vertical: screenWidth(20),
            ),
            height: screenWidth(300),
            color: Appcolor.white,
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return PostCard(
                controller: controller,
                nameProfile: "Jhon Techson",
                history: "5 day",
                onTap: () {
                  Get.dialog(
                    Dialog(
                      child: CodeView(
                        mode: CodeViewMode.view,
                        isdialog: true,
                        code: 'hello world!',
                      ),
                    ),
                  );
                  // Get.dialog(
                  //   CodeDialog(
                  //     codeContainer: CodeView(code: "hello world", isClose: true, isCopy: true),
                  //   ),
                  // );
                },
                textPost:
                    "What's wrong with this code? Getting an error and can't figure out why 🤔",
                numfav: '25.6k',
                numComment: '25.6k',
                numSaved: '25.6k',
              );
            },
          ),
          SizedBox(height: screenWidth(5)),
        ],
      ),
    );
  }
}
