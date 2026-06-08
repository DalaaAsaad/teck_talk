import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents({
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
        horizontal: screenWidth(38),
        vertical: screenWidth(36),
      ),
      decoration: BoxDecoration(
        color: Appcolor.Black_05,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.dark_20.withAlpha(90)),
      ),
      child: Row(
        children: [
          Icon(Icons.drag_indicator_rounded, color: Appcolor.gray_60),
          SizedBox(width: screenWidth(18)),
          Container(
            width: screenWidth(16),
            height: screenWidth(16),
            decoration: BoxDecoration(
              color: Appcolor.black_08,
              border: Border.all(color: Appcolor.yellow_70),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: '${index + 1}',
              styleType: TextStyleType.CUSTOM,
              textColor: Appcolor.yellow_70,
              fontSize: screenWidth(34),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: screenWidth(18)),
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    autofocus: true,
                    style: TextStyle(
                      color: Appcolor.gray_95,
                      fontSize: screenWidth(28),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => onSave(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomText(
                      text: title,
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.gray_95,
                      fontSize: screenWidth(28),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          if (canEdit)
            isEditing
                ? Row(
                    children: [
                      IconButton(
                        onPressed: onSave,
                        icon: const Icon(
                          Icons.check_rounded,
                          color: Appcolor.yellow_70,
                        ),
                        tooltip: 'Save',
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: onStartEdit,
                    icon: const Icon(
                      Icons.edit_rounded,
                      color: Appcolor.yellow_70,
                    ),
                    tooltip: 'Edit section name',
                  ),
          if (canDelete)
            GestureDetector(
              onTap: onDelete,
              child: Container(
                width: screenWidth(16),
                height: screenWidth(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Appcolor.yellow_70),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: Appcolor.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
