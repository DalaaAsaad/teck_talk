import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TitleUml extends StatelessWidget {
  const TitleUml({super.key, required this.isResult});

  final bool isResult;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'UML Designer',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Appcolor.white,
                fontSize: Responsive.sp(0.045),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.hp(0.002)),
            Text(
              'Describe your idea, get a diagram',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Appcolor.muted,
                fontSize: Responsive.sp(0.027),
              ),
            ),
          ],
        ),
        if (isResult)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.02),
              vertical: Responsive.hp(0.004),
            ),
            decoration: BoxDecoration(
              color: Appcolor.successDim,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Appcolor.success, width: 0.6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check, color: Appcolor.success, size: Responsive.sp(0.025)),
                SizedBox(width: Responsive.wp(0.008)),
                Text(
                  'READY',
                  style: TextStyle(
                    color: Appcolor.success,
                    fontSize: Responsive.sp(0.022),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}