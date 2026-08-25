import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// بيفتح Bottom Sheet فيه كل التاغز المتاحة كـ chips قابلة للتبديل.
/// [selectedTagIds] بينعدّل مباشرة (RxSet)، فأي شاشة عم تراقبه هترتبط
/// تلقائياً بالتغيير بدون الحاجة لأي callback إضافي.
void showTagsPickerSheet({
  required RxList<Tag> availableTags,
  required RxSet<int> selectedTagIds,
  required RxBool isLoadingTags,
}) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.fromLTRB(
        Responsive.wp(0.05),
        Responsive.hp(0.018),
        Responsive.wp(0.05),
        Responsive.hp(0.03),
      ),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: Responsive.wp(0.1),
              height: 4,
              decoration: BoxDecoration(
                color: Appcolor.panelEdge,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          SizedBox(height: Responsive.hp(0.02)),
          CustomText(
            text: 'Select tags',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.045),
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: Responsive.hp(0.018)),
          Obx(() {
            if (isLoadingTags.value) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.04)),
                child: Center(
                  child: CircularProgressIndicator(color: Appcolor.accent),
                ),
              );
            }
            if (availableTags.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.04)),
                child: Center(
                  child: CustomText(
                    text: 'No tags available',
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.muted,
                    fontSize: Responsive.sp(0.037),
                  ),
                ),
              );
            }
            return Wrap(
              spacing: Responsive.wp(0.025),
              runSpacing: Responsive.hp(0.012),
              children: availableTags.map((tag) {
                final isSelected = selectedTagIds.contains(tag.id);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedTagIds.remove(tag.id);
                    } else {
                      selectedTagIds.add(tag.id);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.wp(0.035),
                      vertical: Responsive.hp(0.011),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Appcolor.accent : Appcolor.bg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Appcolor.accent
                            : Appcolor.panelEdge,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected) ...[
                          Icon(
                            Icons.check_rounded,
                            color: Appcolor.white,
                            size: Responsive.sp(0.038),
                          ),
                          SizedBox(width: Responsive.wp(0.012)),
                        ],
                        CustomText(
                          text: tag.name,
                          styleType: TextStyleType.CUSTOM,
                          textColor: Appcolor.white,
                          fontSize: Responsive.sp(0.035),
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          SizedBox(height: Responsive.hp(0.026)),
          SizedBox(
            width: double.infinity,
            height: Responsive.hp(0.058),
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: CustomText(
                text: 'Done',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.04),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}