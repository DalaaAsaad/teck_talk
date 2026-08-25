import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class GenerateButton extends StatelessWidget {
  const GenerateButton({
    super.key,
    required this.isLoading,
    required this.canGenerate,
    required this.onGenerate,
  });

  final bool isLoading;
  final bool canGenerate;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    final bool enabled = canGenerate && !isLoading;

    return SizedBox(
      width: double.infinity,
      height: Responsive.hp(0.06),
      child: ElevatedButton(
        onPressed: enabled ? onGenerate : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? Appcolor.accent : Appcolor.panel,
          disabledBackgroundColor: Appcolor.panel,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Responsive.sp(0.025)),
            side: BorderSide(
              color: enabled ? Appcolor.accent : Appcolor.panelEdge,
              width: Responsive.sp(0.003),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.03)),
        ),
        child: isLoading
            ? SizedBox(
                width: Responsive.sp(0.05),
                height: Responsive.sp(0.05),
                child: CircularProgressIndicator(
                  color: Appcolor.white,
                  strokeWidth: Responsive.sp(0.004),
                ),
              )
            : Text(
                'Generate Diagram',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: canGenerate ? Appcolor.white : Appcolor.muted,
                  fontSize: Responsive.sp(0.035),
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}