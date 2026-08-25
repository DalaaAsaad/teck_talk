import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// كارد قسم واحد بنمط Accordion: هيدر (رقم + عنوان + تعديل + حذف) قابل
/// للفتح والسكر، وجوّاه TextField لمحتوى القسم لما يكون مفتوح.
/// منطق "قسم واحد مفتوح بلحظة" محكوم من الكونترولر عبر [isExpanded].
class AccordionSectionCard extends StatelessWidget {
  final int index;
  final String title;
  final bool isExpanded;
  final bool isEditingTitle;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final bool canDelete;
  final VoidCallback onToggleExpand;
  final VoidCallback onStartEditTitle;
  final VoidCallback onSaveTitle;
  final VoidCallback onDelete;

  const AccordionSectionCard({
    super.key,
    required this.index,
    required this.title,
    required this.isExpanded,
    required this.isEditingTitle,
    required this.titleController,
    required this.contentController,
    required this.onToggleExpand,
    required this.onStartEditTitle,
    required this.onSaveTitle,
    required this.onDelete,
    this.canDelete = true,
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
            onTap: isEditingTitle ? null : onToggleExpand,
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
                    child: isEditingTitle
                        ? TextField(
                            controller: titleController,
                            autofocus: true,
                            cursorColor: Appcolor.accent,
                            style: TextStyle(
                              color: Appcolor.white,
                              fontSize: Responsive.sp(0.037),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => onSaveTitle(),
                          )
                        : CustomText(
                            text: title,
                            styleType: TextStyleType.CUSTOM,
                            textColor: Appcolor.white,
                            fontSize: Responsive.sp(0.037),
                            fontWeight: FontWeight.w500,
                          ),
                  ),
                  IconButton(
                    onPressed: isEditingTitle ? onSaveTitle : onStartEditTitle,
                    icon: Icon(
                      isEditingTitle ? Icons.check_rounded : Icons.edit_outlined,
                      color: isEditingTitle ? Appcolor.accent : Appcolor.muted,
                      size: Responsive.sp(0.045),
                    ),
                    tooltip: isEditingTitle ? 'Save' : 'Edit section name',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  if (canDelete) ...[
                    SizedBox(width: Responsive.wp(0.02)),
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        width: Responsive.wp(0.07),
                        height: Responsive.wp(0.07),
                        decoration: BoxDecoration(
                          color: Appcolor.panel,
                          borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
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
              child: Container(
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
            ),
        ],
      ),
    );
  }
}