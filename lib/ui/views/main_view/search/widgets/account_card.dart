import 'package:flutter/material.dart';
import 'package:teck_talk/core/data/models/accounts_model.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class AccountCard extends StatelessWidget {
  final AccountsModel account;
  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth(28)),
      decoration: BoxDecoration(
        color: Appcolor.Black_05,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Appcolor.gray_60.withAlpha(70), width: 0.8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth(15),
            backgroundImage: AssetImage(account.imagePath),
          ),
          SizedBox(width: screenWidth(35)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: account.name,
                  styleType: TextStyleType.CUSTOM,
                  fontSize: screenWidth(20),
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: screenWidth(90)),
                CustomText(
                  text: account.username,
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.gray_60,
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth(35)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(30),
              vertical: screenWidth(30),
            ),
            decoration: BoxDecoration(
              color: Appcolor.black_08,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Appcolor.gray_60.withAlpha(50)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Follow',
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.gray_60,
                ),
                SizedBox(width: screenWidth(50)),
                Icon(
                  Icons.add,
                  color: Appcolor.yellow_70,
                  size: screenWidth(15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
