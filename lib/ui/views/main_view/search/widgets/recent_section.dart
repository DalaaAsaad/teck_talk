import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/search_controller.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class RecentSection extends GetView<Search_Controller> {
  const RecentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Recent',
                styleType: TextStyleType.CUSTOM,
                fontSize: screenWidth(18),
                fontWeight: FontWeight.bold,
              ),
              InkWell(
                onTap: controller.clearRecentSearches,
                child: CustomText(
                  text: 'Clear all',
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.yellow_70,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth(25)),
          Expanded(
            child: controller.recentSearches.isEmpty
                ? Center(
                    child: CustomText(
                      text: 'No recent searches',
                      styleType: TextStyleType.BODY,
                      textColor: Appcolor.gray_60,
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.recentSearches.length,
                    itemBuilder: (context, index) {
                      final term = controller.recentSearches[index];
                      return RecentItem(
                        title: term,
                        onTap: () => controller.selectRecentSearch(term),
                        onDelete: () => controller.removeRecentSearch(term),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class RecentItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RecentItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth(80)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(text: title, styleType: TextStyleType.BODY),
            ),
            InkWell(
              onTap: onDelete,
              child: Icon(Icons.close, color: Appcolor.gray_60),
            ),
          ],
        ),
      ),
    );
  }
}
