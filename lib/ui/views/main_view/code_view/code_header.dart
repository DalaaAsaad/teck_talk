import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/views/main_view/code_view/code_model.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class CodeHeader extends StatelessWidget {
  final CodeViewMode mode;
  final bool isDialog;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onCopy;

  const CodeHeader({
    super.key,
    required this.mode,
    required this.isDialog,
    required this.isExpanded,
    required this.onToggle,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Appcolor.yellow_70),
            SizedBox(width: screenWidth(20)),

            CustomText(
              text: "Code",
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(20),
              fontWeight: FontWeight.w400,
            ),
          ],
        ),

        Row(
          children: [
            if (mode == CodeViewMode.view)
              IconButton(
                onPressed: onCopy,
                icon: Icon(Icons.copy, color: Appcolor.yellow_70),
              ),

            if (mode == CodeViewMode.input)
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.add_box_outlined, color: Appcolor.yellow_70),
              ),

            if (isDialog)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.close,
                  color: Appcolor.yellow_70,
                  size: screenWidth(15),
                ),
              )
            else
              IconButton(
                onPressed: onToggle,
                icon: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Appcolor.yellow_70,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
