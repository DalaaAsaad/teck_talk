import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/main_view/main_view_controller.dart';

class TagWidget extends StatelessWidget {
  final String text;
  const TagWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final mainController = Get.find<MainViewController>();
        mainController.changeTab(3);
        final searchController = Get.find<Search_Controller>();
        searchController.setSearchFromTag(text);
      },
      child: CustomText(
        text: "#" + text,
        styleType: TextStyleType.CUSTOM,
        fontSize: screenWidth(25),
        textColor: Appcolor.yellow_70,
      ),
    );
  }
}
