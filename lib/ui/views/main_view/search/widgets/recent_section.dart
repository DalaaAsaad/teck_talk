import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class RecentSection extends GetView<Search_Controller> {
  const RecentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Recent',
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.045),
                fontWeight: FontWeight.bold,
                textColor: Appcolor.white,
              ),
              InkWell(
                onTap: controller.clearRecentSearches,
                borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.wp(0.025),
                    vertical: Responsive.hp(0.006),
                  ),
                  decoration: BoxDecoration(
                    color: Appcolor.accentDim,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: CustomText(
                    text: 'Clear all',
                    styleType: TextStyleType.BODY,
                    fontSize: Responsive.sp(0.032),
                    textColor: Appcolor.accent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.hp(0.015)),
          Expanded(
            child: controller.recentSearches.isEmpty
                ? Center(
                    child: CustomText(
                      text: 'No recent searches',
                      styleType: TextStyleType.BODY,
                      textColor: Appcolor.label,
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: Responsive.hp(0.12)),
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
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.hp(0.01)),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
        border: Border.all(color: Appcolor.panelEdge, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.hp(0.01),
            horizontal: Responsive.wp(0.03),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(Responsive.wp(0.018)),
                decoration: BoxDecoration(
                  color: Appcolor.bg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: Appcolor.muted,
                  size: Responsive.sp(0.045),
                ),
              ),
              SizedBox(width: Responsive.wp(0.03)),
              Expanded(
                child: CustomText(
                  text: title,
                  styleType: TextStyleType.BODY,
                  textColor: Appcolor.white,
                ),
              ),
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: EdgeInsets.all(Responsive.wp(0.015)),
                  child: Icon(
                    Icons.close_rounded,
                    color: Appcolor.label,
                    size: Responsive.sp(0.045),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}