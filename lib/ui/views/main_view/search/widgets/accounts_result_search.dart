import 'package:flutter/material.dart';
import 'package:tech_talk/core/data/models/user_general_model.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class AccountsResultSearch extends StatelessWidget {
  const AccountsResultSearch({
    super.key,
    required this.account,
  });

  final UserGeneralModel account;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(
        Responsive.wp(0.04),
      ),

      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(
          Responsive.wp(0.045),
        ),
        border: Border.all(
          color: Appcolor.panelEdge,
          width: 1,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // =========================
          // Avatar
          // =========================
          CircleAvatar(
            radius: Responsive.wp(0.075),

            backgroundColor: Appcolor.panelEdge,

            backgroundImage: account.avatarUrl.isNotEmpty
                ? NetworkImage(account.avatarUrl)
                : null,

            onBackgroundImageError: (_, __) {},

            child: account.avatarUrl.isEmpty
                ? Icon(
                    Icons.person_rounded,
                    color: Appcolor.muted,
                    size: Responsive.sp(0.06),
                  )
                : null,
          ),

          SizedBox(
            width: Responsive.wp(0.035),
          ),

          // =========================
          // User information
          // =========================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: account.name,
                  styleType: TextStyleType.CUSTOM,
                  fontSize: Responsive.sp(0.042),
                  fontWeight: FontWeight.w700,
                  textColor: Appcolor.white,
       
                ),

                SizedBox(
                  height: Responsive.hp(0.005),
                ),

                CustomText(
                  text: '@${account.username}',
                  styleType: TextStyleType.BODY,
                  fontSize: Responsive.sp(0.034),
                  textColor: Appcolor.muted,
     
                ),
              ],
            ),
          ),

          SizedBox(
            width: Responsive.wp(0.025),
          ),

          // =========================
          // Follow button
          // =========================
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.025),
              vertical: Responsive.hp(0.009),
            ),

            decoration: BoxDecoration(
              color: Appcolor.bg,
              borderRadius: BorderRadius.circular(
                Responsive.wp(0.035),
              ),
              border: Border.all(
                color: Appcolor.panelEdge,
                width: 1,
              ),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Follow',
                  styleType: TextStyleType.BODY,
                  fontSize: Responsive.sp(0.032),
                  fontWeight: FontWeight.w500,
                  textColor: Appcolor.muted,
                ),

                SizedBox(
                  width: Responsive.wp(0.015),
                ),

                Icon(
                  Icons.add_rounded,
                  color: Appcolor.accent,
                  size: Responsive.sp(0.045),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}