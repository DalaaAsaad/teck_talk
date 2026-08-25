// import 'package:dots_indicator/dots_indicator.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

import 'package:tech_talk/ui/views/intro/intro_controller.dart';

import 'package:tech_talk/ui/views/intro/widgets/get_started_button.dart';
import 'package:tech_talk/ui/views/intro/widgets/intro_page_widget.dart';

// ── Colour tokens (consistent with Edit Profile redesign) ──────

// ── Page data (unchanged) ──────────────────────────────────────
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

// =============================================================
//  INTRO SCREEN  — logic unchanged, visuals redesigned
// =============================================================
class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late PageController _pageController;
  bool _isSkipPressed = false;
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
        backgroundColor: Appcolor.bg,
        body: Column(
          children: [
            // ── Skip row ──────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.hp(0.04),
                vertical: Responsive.wp(0.04),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: controller.navigateToSignin,
                    onTapDown: (_) => setState(() => _isSkipPressed = true),
                    onTapUp: (_) => setState(() => _isSkipPressed = false),
                    onTapCancel: () => setState(() => _isSkipPressed = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 120),
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.hp(0.03),
                        vertical: Responsive.wp(0.02),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _isSkipPressed
                              ? Appcolor.accent
                              : Appcolor.panelEdge,
                        ),
                        color: _isSkipPressed
                            ? Appcolor.accentDim
                            : Appcolor.panel,
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: _isSkipPressed
                              ? Appcolor.accent
                              : Appcolor.muted,
                          fontSize: Responsive.sp(0.04),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── PageView ──────────────────────────────────────
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
            Obx(
              () => DotsIndicator(
                dotsCount: pages.length,
                position: controller.currentPage.value,
                decorator: DotsDecorator(
                  color: Appcolor.panelEdge,
                  activeColor: Appcolor.accent,
                  size: const Size.square(8),
                  activeSize: const Size(28, 8),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: Responsive.hp(0.04),
                horizontal: Responsive.hp(0.04),
              ),
              child: Column(
                children: [
                  SizedBox(height: Responsive.hp(0.02)),
                  Obx(
                    () => controller.currentPage.value == pages.length - 1
                        ? GetStartedButton(controller: controller)
                        : SizedBox(height: Responsive.hp(0.07)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
