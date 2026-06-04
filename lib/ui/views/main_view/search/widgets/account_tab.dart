import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/search_controller.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/account_card.dart';

class AccountTab extends GetView<Search_Controller> {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final accounts = controller.accounts;

      if (accounts.isEmpty) {
        return Center(
          child: CustomText(
            text: 'No accounts found for this search',
            styleType: TextStyleType.BODY,
            textColor: Appcolor.gray_60,
          ),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.only(top: screenWidth(30), bottom: screenWidth(5)),
        itemCount: accounts.length,
        separatorBuilder: (context, index) => SizedBox(height: screenWidth(35)),
        itemBuilder: (context, index) {
          return AccountCard(account: accounts[index]);
        },
      );
    });
  }
}
