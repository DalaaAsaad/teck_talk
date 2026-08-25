import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/account_card.dart';

class AccountTab extends GetView<Search_Controller> {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final accounts = controller.accounts;

      // No accounts
      if (accounts.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.08)),
            child: CustomText(
              text: 'No accounts found for this search',
              styleType: TextStyleType.BODY,
              textColor: Appcolor.muted,
              fontSize: Responsive.sp(0.038),
            ),
          ),
        );
      }

      // Accounts list
      return ListView.separated(
        padding: EdgeInsets.only(
          top: Responsive.hp(0.015),
          bottom: Responsive.hp(0.01),
          left: Responsive.wp(0.01),
          right: Responsive.wp(0.01),
        ),
        itemCount: accounts.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: Responsive.hp(0.012));
        },
        itemBuilder: (context, index) {
          return AccountCard(account: accounts[index]);
        },
      );
    });
  }
}
