import 'package:flutter/material.dart';
import 'package:tech_talk/core/data/models/user_general_model.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class AccountCard extends StatelessWidget {
  final UserGeneralModel account;

  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.032),
        vertical: Responsive.hp(0.010),
      ),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.wp(0.04)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // =========================
          // Avatar
          // =========================
          CircleAvatar(
            radius: Responsive.wp(0.048),
            backgroundColor: Appcolor.bg,
            backgroundImage: account.avatarUrl.isNotEmpty
                ? NetworkImage(account.avatarUrl)
                : null,
            onBackgroundImageError: (_, __) {},
            child: account.avatarUrl.isEmpty
                ? Icon(
                    Icons.person_rounded,
                    color: Appcolor.muted,
                    size: Responsive.sp(0.045),
                  )
                : null,
          ),

          SizedBox(width: Responsive.wp(0.03)),

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
                  fontSize: Responsive.sp(0.037),
                  fontWeight: FontWeight.w600,
                  textColor: Appcolor.white,
                ),
                SizedBox(height: Responsive.hp(0.003)),
                CustomText(
                  text: '@${account.username}',
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.muted,
                  fontSize: Responsive.sp(0.03),
                ),
              ],
            ),
          ),

          SizedBox(width: Responsive.wp(0.02)),

          // =========================
          // Follow button
          // =========================
          const _FollowButton(),
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.026),
            vertical: Responsive.hp(0.007),
          ),
          decoration: BoxDecoration(
            color: Appcolor.accentDim,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Follow',
                styleType: TextStyleType.SMALL,
                fontWeight: FontWeight.w600,
                textColor: Appcolor.accent,
              ),
              SizedBox(width: Responsive.wp(0.008)),
              Icon(
                Icons.add_rounded,
                color: Appcolor.accent,
                size: Responsive.sp(0.032),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
