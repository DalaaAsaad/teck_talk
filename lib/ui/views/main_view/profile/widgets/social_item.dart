import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';


class SocialItem extends StatelessWidget {
  final String iconPath;
  // final String label;
   bool tintWhite;
   SocialItem({
    super.key,
    required this.iconPath,
    // required this.label,
     this.tintWhite=false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 38,
          color: tintWhite ? Appcolor.white : null,
        ),
        const SizedBox(height: 6),
        // Text(
        //   label,
        //   style: TextStyle(
        //     color: Appcolor.gray_95,
        //     fontSize: screenWidth(34),
        //     fontWeight: FontWeight.w400,
        //   ),
        // ),
      ],
    );
  }
}
