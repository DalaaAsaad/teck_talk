import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/intro/intro.dart';
import 'package:tech_talk/ui/views/intro/widgets/goal_item.dart';
import 'package:tech_talk/ui/views/intro/widgets/illustration.dart';

class IntroPageWidget extends StatelessWidget {
  final IntroPageData data;
  const IntroPageWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.07)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Center(child: Illustration(type: data.iconType)),
          ),

          // ── Content zone ─────────────────────────────────
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: Responsive.sp(0.07),
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: Responsive.hp(0.01)),

                  // Subtitle lines
                  ...data.subtitles.map(
                    (s) => Text(
                      s,
                      style: TextStyle(
                        color: Appcolor.muted,
                        fontSize: Responsive.sp(0.04),
                        height: 1.45,
                      ),
                    ),
                  ),  

                  // Goal items
                  if (data.goals.isNotEmpty)
                    SizedBox(height: Responsive.hp(0.02)),
                  ...data.goals.map((g) => GoalItem(text: g)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
