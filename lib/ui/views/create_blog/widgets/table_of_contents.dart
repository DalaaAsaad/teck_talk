import 'package:flutter/material.dart';

import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents({
    super.key,
    required this.index,
    required this.title,
    required this.onDelete,
    required this.controller,
    required this.isEditing,
    required this.onStartEdit,
    required this.onSave,
    required this.onCancel,
    this.canDelete = true,
    this.canEdit = true,
  });

  final int index;
  final String title;
  final VoidCallback onDelete;
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback onStartEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final bool canDelete;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.025),
        vertical: Responsive.wp(0.02),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.025),
        vertical: Responsive.wp(0.02),
      ),

      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
        border: Border.all(
          color: isEditing ? Appcolor.accent : Appcolor.panelEdge,
          width: Responsive.wp(0.0025),
        ),
      ),

      child: Row(
        children: [
          Icon(
            Icons.drag_indicator_rounded,
            color: Appcolor.muted,
            size: Responsive.sp(0.055),
          ),

          SizedBox(width: Responsive.wp(0.035)),

          Container(
            width: Responsive.wp(0.09),
            height: Responsive.wp(0.09),

            decoration: BoxDecoration(
              color: Appcolor.accentDim,
              borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
            ),

            alignment: Alignment.center,

            child: CustomText(
              text: '${index + 1}',
              styleType: TextStyleType.CUSTOM,
              textColor: Appcolor.accent,
              fontSize: Responsive.sp(0.038),
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(width: Responsive.wp(0.035)),

          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
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

                    onSubmitted: (_) => onSave(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Responsive.wp(0.01),
                    ),

                    child: CustomText(
                      text: title,
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.white,
                      fontSize: Responsive.sp(0.037),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),

          if (canEdit)
            isEditing
                ? IconButton(
                    onPressed: onSave,
                    icon: Icon(
                      Icons.check_rounded,
                      color: Appcolor.accent,
                      size: Responsive.sp(0.055),
                    ),
                    tooltip: 'Save',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )
                : IconButton(
                    onPressed: onStartEdit,
                    icon: Icon(
                      Icons.edit_rounded,
                      color: Appcolor.muted,
                      size: Responsive.sp(0.05),
                    ),
                    tooltip: 'Edit section name',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

          if (canDelete) ...[
            SizedBox(width: Responsive.wp(0.02)),
            GestureDetector(
              onTap: onDelete,
              child: Container(
                width: Responsive.wp(0.075),
                height: Responsive.wp(0.075),

                decoration: BoxDecoration(
                  color: Appcolor.bg,
                  borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
                  border: Border.all(
                    color: Appcolor.panelEdge,
                    width: Responsive.wp(0.0025),
                  ),
                ),

                alignment: Alignment.center,

                child: Icon(
                  Icons.close_rounded,
                  size: Responsive.sp(0.04),
                  color: Appcolor.muted,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
