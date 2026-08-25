import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class CodeHeader extends StatelessWidget {
  final CodeViewMode mode;
  final bool isDialog;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onCopy;
  final VoidCallback? onSave;
  final VoidCallback? onClose;

  const CodeHeader({
    super.key,
    required this.mode,
    required this.isDialog,
    required this.isExpanded,
    required this.onToggle,
    this.onCopy,
    this.onSave,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.wp(0.014)),
              decoration: BoxDecoration(
                color: Appcolor.accent.withAlpha(35),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.code_rounded,
                color: Appcolor.accent,
                size: Responsive.sp(0.045),
              ),
            ),
            SizedBox(width: Responsive.wp(0.024)),
            CustomText(
              text: "Code",
              styleType: TextStyleType.CUSTOM,
              fontSize: Responsive.sp(0.048),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),

        Row(
          children: [
            if (mode == CodeViewMode.view)
              _HeaderAction(
                icon: Icons.copy_rounded,
                onTap: onCopy,
                tooltip: "Copy code",
              ),

            if (mode == CodeViewMode.input)
              _HeaderAction(
                icon: Icons.save_alt_rounded,
                onTap: onSave,
                tooltip: "Save code",
              ),

            if (isDialog)
              _HeaderAction(
                icon: Icons.close_rounded,
                onTap: onClose,
                tooltip: "Close",
              )
            else
              _HeaderAction(
                onTap: onToggle,
                tooltip: isExpanded ? "Collapse" : "Expand",
                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  turns: isExpanded ? 0.5 : 0,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.05),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _HeaderAction extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onTap;
  final String? tooltip;

  const _HeaderAction({this.icon, this.child, this.onTap, this.tooltip})
    : assert(icon != null || child != null);

  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Responsive.wp(0.008)),
        padding: EdgeInsets.all(Responsive.wp(0.02)),
        decoration: BoxDecoration(
          color: Appcolor.panel.withAlpha(90),
          shape: BoxShape.circle,
        ),
        child:
            child ??
            Icon(icon, color: Appcolor.accent, size: Responsive.sp(0.045)),
      ),
    );

    if (tooltip == null) return button;

    return Tooltip(message: tooltip!, child: button);
  }
}
