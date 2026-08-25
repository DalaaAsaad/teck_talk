import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class ResultButtons extends StatelessWidget {
  const ResultButtons({
    super.key,
    required this.exportPressed,
    required this.onRegenerate,
    required this.onExport,
  });

  final bool exportPressed;
  final VoidCallback onRegenerate;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message: 'Regenerate',
          child: SizedBox(
            width: Responsive.wp(0.14),
            height: Responsive.hp(0.06),
            child: OutlinedButton(
              onPressed: onRegenerate,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Appcolor.panelEdge,
                  width: Responsive.sp(0.003),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.sp(0.025)),
                ),
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
              ),
              child: Icon(
                Icons.refresh,
                color: Appcolor.white,
                size: Responsive.sp(0.045),
              ),
            ),
          ),
        ),

        SizedBox(width: Responsive.wp(0.03)),

        Expanded(
          child: SizedBox(
            height: Responsive.hp(0.06),
            child: ElevatedButton(
              onPressed: onExport,
              style: ElevatedButton.styleFrom(
                backgroundColor: exportPressed
                    ? Appcolor.accent.withOpacity(0.7)
                    : Appcolor.accent,
                foregroundColor: Appcolor.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Responsive.sp(0.025)),
                ),
              ),
              child: Text(
                'Export PNG',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: Responsive.sp(0.035),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}