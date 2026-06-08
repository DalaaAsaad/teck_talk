import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class XpbarProfile extends GetView<ProfileController> {
  const XpbarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    int currentXP = controller.profileData.value?.rankingPoints ?? 0;
    int maxXP = 10000;

    final double progress = (currentXP / maxXP).clamp(0.0, 1.0);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double labelLeft = ((width * progress) - 20).clamp(
          0.0,
          width - 56,
        );

        return Column(
          children: [
            SizedBox(
              height: screenWidth(15),
              child: Stack(
                children: [
                  Positioned(
                    left: labelLeft,
                    child: Text(
                      "${currentXP} xp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Stack(
              children: [
                Container(
                  height: screenWidth(50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Appcolor.white.withAlpha(180),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    height: screenWidth(50),
                    decoration: BoxDecoration(
                      color: Appcolor.yellow_70,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenWidth(80)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "0 xp",
                  style: TextStyle(color: Colors.white54, fontSize: 10),
                ),
                Text(
                  "$maxXP xp",
                  style: TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
