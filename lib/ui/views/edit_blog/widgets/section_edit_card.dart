import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// كارد سيكشن واحد بنمط Accordion. بلا زر حفظ خاص فيها - أي تعديل هون
/// بضل محلي بس، وبينبعت مع باقي التغييرات دفعة وحدة لما تدوس "Save
/// Changes" بأسفل الشاشة.
class SectionEditCard extends StatelessWidget {
  final int index;
  final String displayTitle;
  final bool isExpanded;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final VoidCallback onToggleExpand;
  final VoidCallback onDelete;

  const SectionEditCard({
    super.key,
    required this.index,
    required this.displayTitle,
    required this.isExpanded,
    required this.titleController,
    required this.contentController,
    required this.onToggleExpand,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.hp(0.014)),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isExpanded
              ? Appcolor.accent.withOpacity(0.5)
              : Appcolor.panelEdge,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onToggleExpand,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.wp(0.03),
                vertical: Responsive.hp(0.014),
              ),
              child: Row(
                children: [
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.chevron_right_rounded,
                    color: isExpanded ? Appcolor.accent : Appcolor.muted,
                    size: Responsive.sp(0.05),
                  ),
                  SizedBox(width: Responsive.wp(0.02)),
                  Container(
                    width: Responsive.wp(0.075),
                    height: Responsive.wp(0.075),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Appcolor.accentDim,
                      borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
                    ),
                    child: CustomText(
                      text: '${index + 1}',
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.accent,
                      fontSize: Responsive.sp(0.032),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: Responsive.wp(0.03)),
                  Expanded(
                    child: CustomText(
                      text: displayTitle,
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.white,
                      fontSize: Responsive.sp(0.037),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      width: Responsive.wp(0.07),
                      height: Responsive.wp(0.07),
                      decoration: BoxDecoration(
                        color: Appcolor.panel,
                        borderRadius: BorderRadius.circular(
                          Responsive.wp(0.02),
                        ),
                        border: Border.all(color: Appcolor.panelEdge),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close_rounded,
                        size: Responsive.sp(0.038),
                        color: Appcolor.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(
                Responsive.wp(0.03),
                0,
                Responsive.wp(0.03),
                Responsive.hp(0.016),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.wp(0.035),
                      vertical: Responsive.hp(0.011),
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.panel,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Appcolor.panelEdge),
                    ),
                    child: TextField(
                      controller: titleController,
                      cursorColor: Appcolor.accent,
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: Responsive.sp(0.037),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Section title',
                        hintStyle: TextStyle(
                          color: Appcolor.muted,
                          fontSize: Responsive.sp(0.037),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.hp(0.012)),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: Responsive.hp(0.09)),
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.wp(0.035),
                      vertical: Responsive.hp(0.012),
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.panel,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Appcolor.panelEdge),
                    ),
                    child: TextField(
                      controller: contentController,
                      maxLines: null,
                      minLines: 4,
                      cursorColor: Appcolor.accent,
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: Responsive.sp(0.038),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Write content for this section...',
                        hintStyle: TextStyle(
                          color: Appcolor.muted,
                          fontSize: Responsive.sp(0.038),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}