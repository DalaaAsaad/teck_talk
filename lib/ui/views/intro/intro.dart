import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart'
    show screenWidth;
import 'package:teck_talk/ui/views/intro/intro_controller.dart';

//   * information about my app

class IntroPageData {
  final String iconType;
  final String title;
  final List<String> subtitles;
  final List<String> goals;

  IntroPageData({
    required this.iconType,
    required this.title,
    required this.subtitles,
    required this.goals,
  });
}

final List<IntroPageData> pages = [
  IntroPageData(
    iconType: 'logo',
    title: 'Welcome to TechTalk',
    subtitles: [
      'The first platform that brings',
      'developers together in one interactive',
      'community',
    ],
    goals: [],
  ),
  IntroPageData(
    iconType: 'light',
    title: 'Share. Solve. Grow',
    subtitles: [
      'Post your coding issues and get',
      'solutions from experienced developers',
      'in real-time',
    ],
    goals: [
      'Debug code with community help',
      'Discuss different approaches',
      'Learn from others\' mistakes',
    ],
  ),
  IntroPageData(
    iconType: 'build',
    title: 'Learn. Build. Innovate',
    subtitles: [
      'Access expert articles, tutorials, and an',
      'AI assistant that helps you 24/7 with',
      'your code',
    ],
    goals: [
      'In-depth tech articles',
      'AI-powered coding assistant',
      'Save and share knowledge',
    ],
  ),
];

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late PageController _pageController;
  final IntroController controller = Get.put(IntroController());

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
                // * Skip button
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: screenWidth(20.55),
                    start: screenWidth(1.4),
                    bottom: screenWidth(7),
                  ),
                  child: InkWell(
                    onTap: controller.navigateToSignin,
                    child: CustomText(
                      text: "skip",
                      fontSize: screenWidth(20),
                      textColor: Appcolor.yellow_70,
                    ),
                  ),
                ),

                // * pageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) =>
                        controller.currentPage.value = index.toDouble(),
                    itemBuilder: (context, index) =>
                        IntroPageWidget(data: pages[index]),
                  ),
                ),

                // * Dots Indicator
                Obx(
                  () => DotsIndicator(
                    dotsCount: pages.length,
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

                // * Get Started button
                Obx(
                  () => controller.currentPage.value == pages.length - 1
                      ? GetStartedButton()
                      : SizedBox(),
                ),
                SizedBox(height: screenWidth(5)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// * intro page ....

class IntroPageWidget extends StatelessWidget {
  final IntroPageData data;
  const IntroPageWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: screenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconWidget(type: data.iconType),
              SizedBox(width: screenWidth(20)),
              CustomText(text: data.title, styleType: TextStyleType.SUBTITLE),
            ],
          ),
          SizedBox(height: screenWidth(10)),
          ...data.subtitles.map(
            (s) => CustomText(text: s, styleType: TextStyleType.BODY),
          ),
          SizedBox(height: screenWidth(3)),
          ...data.goals.map((g) => GoalItem(text: g)),
        ],
      ),
    );
  }
}

//*  goal item
class GoalItem extends StatelessWidget {
  final String text;
  const GoalItem({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return SizedBox();
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth(20)),
      child: Row(
        children: [
          Icon(Icons.check, color: Appcolor.yellow_70),
          Expanded(
            child: CustomText(text: text, styleType: TextStyleType.BODY),
          ),
        ],
      ),
    );
  }
}

//* icon widget

class IconWidget extends StatelessWidget {
  final String type;
  const IconWidget({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'logo':
        return SvgPicture.asset(
          "assets/images/svg/logo.svg",
          width: screenWidth(8),
        );
      case 'light':
        return Icon(
          Icons.lightbulb_sharp,
          color: Appcolor.yellow_70,
          size: screenWidth(8),
        );
      default:
        return Icon(
          Icons.build_rounded,
          color: Appcolor.yellow_70,
          size: screenWidth(8),
        );
    }
  }
}

//*  started   Button
class GetStartedButton extends StatelessWidget {
  final IntroController controller = Get.find<IntroController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: controller.navigateToSignin,
        onTapDown: (_) => controller.isPressed.value = true,
        onTapUp: (_) => controller.isPressed.value = false,
        onTapCancel: () => controller.isPressed.value = false,
        child: Container(
          height: screenWidth(6),
          width: screenWidth(1.2),
          decoration: BoxDecoration(
            color: controller.isPressed.value
                ? Appcolor.yellow_70
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Appcolor.yellow_70, width: 2),
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
      ),
    );
  }
}
