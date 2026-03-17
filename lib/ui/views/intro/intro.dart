import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart'
    show screenWidth;
import 'package:teck_talk/ui/views/intro/intro_controller.dart';
import 'package:teck_talk/ui/views/splash/splash.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  IntroController controller = Get.put(IntroController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                "assets/images/jpg/backGround.jpg",
                fit: BoxFit.cover,
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenWidth(20.55),
                    start: screenWidth(1.4),
                    bottom: screenWidth(7),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.off(() => Splash());
                    },
                    child: CustomText(
                      text: "skip",
                      fontSize: screenWidth(20),
                      textColor: Appcolor.yellow_70,
                    ),
                  ),
                ),
                Container(
                  height: screenWidth(0.747),
                  child: PageView(
                    onPageChanged: (value) {
                      controller.currentPage.value = value.toDouble();
                    },
                    controller: _pageController,
                    children: [
                      makePage(
                        iconType: 'logo',
                        title: "Welcome to TechTalk",
                        subtitle1: "The first platform that brings ",
                        subtitle2: "developers together in one interactive ",
                        subtitle3: "community",
                        programGoal1: '',
                        porgramGoal2: '',
                        programGoal3: '',
                      ),
                      makePage(
                        iconType: "light",
                        title: "Share. Solve. Grow",
                        subtitle1: "Post your coding issues and get   ",
                        subtitle2: "solutions from experienced developers ",
                        subtitle3: "in real-time ",
                        programGoal1: " Debug code with community help",
                        porgramGoal2: " Discuss different approaches",
                        programGoal3: " Learn from others' mistakes",
                      ),
                      makePage(
                        iconType: "build",
                        title: "Learn. Build. Innovate",
                        subtitle1:
                            "Access expert articles, tutorials, and an  ",
                        subtitle2: "AI assistant that helps you 24/7 with ",
                        subtitle3: "your code ",
                        programGoal1: " In-depth tech articles",
                        porgramGoal2: " AI-powered coding assistant",
                        programGoal3: " Save and share knowledge",
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => DotsIndicator(
                    dotsCount: 3,
                    position: controller.currentPage.value,
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(30, 9.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      activeColor: Appcolor.yellow_70,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth(10)),
                Obx(
                  () => controller.currentPage.value == 2
                      ? InkWell(
                          onTap: () {
                            Get.off(() => Splash());
                          },
                          onTapDown: (_) {
                            controller.isPressed.value = true;
                          },
                          onTapUp: (_) {
                            controller.isPressed.value = false;
                          },
                          onTapCancel: () {
                            controller.isPressed.value = false;
                          },
                          child: Container(
                            height: screenWidth(6),
                            width: screenWidth(1.2),
                            decoration: BoxDecoration(
                              color: controller.isPressed.value
                                  ? Appcolor.yellow_70
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Appcolor.yellow_70,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: CustomText(
                                text: "Get Started",
                                styleType: TextStyleType.CUSTOM,
                                fontSize: screenWidth(15),
                                textColor: controller.isPressed.value
                                    ? Appcolor.white
                                    : Appcolor.yellow_70,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget makePage({
  required String iconType,
  required String title,
  required String subtitle1,
  required String subtitle2,
  required String subtitle3,
  required String programGoal1,
  required String porgramGoal2,
  required String programGoal3,
}) {
  return Container(
    margin: EdgeInsetsDirectional.only(start: screenWidth(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            iconType == "logo"
                ? SvgPicture.asset(
                    "assets/images/svg/logo.svg",
                    width: screenWidth(8),
                  )
                : iconType == "light"
                ? Icon(
                    Icons.lightbulb_sharp,
                    color: Appcolor.yellow_70,
                    size: screenWidth(8),
                  )
                : Icon(
                    Icons.build_rounded,
                    color: Appcolor.yellow_70,
                    size: screenWidth(8),
                  ),
            SizedBox(width: screenWidth(20)),
            CustomText(text: title, styleType: TextStyleType.SUBTITLE),
          ],
        ),
        SizedBox(height: screenWidth(10)),
        CustomText(text: subtitle1, styleType: TextStyleType.BODY),
        CustomText(text: subtitle2, styleType: TextStyleType.BODY),
        CustomText(text: subtitle3, styleType: TextStyleType.BODY),
        SizedBox(height: screenWidth(3)),
        Row(
          children: [
            programGoal1 == ""
                ? Container()
                : Icon(Icons.check, color: Appcolor.yellow_70),
            CustomText(text: programGoal1, styleType: TextStyleType.BODY),
          ],
        ),
        SizedBox(height: screenWidth(30)),
        Row(
          children: [
            porgramGoal2 == ""
                ? Container()
                : Icon(Icons.check, color: Appcolor.yellow_70),
            CustomText(text: porgramGoal2, styleType: TextStyleType.BODY),
          ],
        ),
        SizedBox(height: screenWidth(30)),
        Row(
          children: [
            programGoal3 == ""
                ? Container()
                : Icon(Icons.check, color: Appcolor.yellow_70),
            CustomText(text: programGoal3, styleType: TextStyleType.BODY),
          ],
        ),
      ],
    ),
  );
}
