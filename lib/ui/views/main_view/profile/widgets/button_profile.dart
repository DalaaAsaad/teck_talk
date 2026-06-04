import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class ButtonProfile extends StatelessWidget {
  const ButtonProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: screenWidth(20),
        bottom: screenWidth(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: screenWidth(9),
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/editprofile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.yellow_70,
                  foregroundColor: Appcolor.black_08,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: CustomText(
                  text: 'Edit profile',
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.black_08,
                  fontSize: screenWidth(22),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth(12)),
          Expanded(
            child: SizedBox(
              height: screenWidth(9),
              child: ElevatedButton(
                onPressed: () {
                  AppSnackBar.success('Profile link shared');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.yellow_70,
                  foregroundColor: Appcolor.black_08,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: CustomText(
                  text: 'Share profile',
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.black_08,
                  fontSize: screenWidth(22),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
