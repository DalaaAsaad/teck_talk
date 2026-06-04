import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/homecontroller.dart';
import 'package:teck_talk/ui/shared/custom_widget/iconwithtitle.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/compiler/compiler.dart';
import 'package:teck_talk/ui/views/roadmaps/roadmaps.dart';
import 'package:teck_talk/ui/views/uml_design/uml_design.dart';

class FloatButton extends GetView<Homecontroller> {
  const FloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
      );
  }
}