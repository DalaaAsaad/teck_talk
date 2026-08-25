import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class OutputPanel extends StatelessWidget {
  const OutputPanel({
    super.key,
    required this.isLoading,
    required this.error,
    required this.output,
    required this.onCopy,
    required this.height,
  });

  final bool isLoading;
  final String error;
  final String output;
  final VoidCallback? onCopy;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: height,
        child: Center(
          child: SizedBox(
            width: Responsive.wp(0.07),
            height: Responsive.wp(0.07),
            child: CircularProgressIndicator(
              strokeWidth: Responsive.wp(0.005),
              valueColor: AlwaysStoppedAnimation(Appcolor.accent),
            ),
          ),
        ),
      );
    }

    final isError = error.isNotEmpty;
    final content = isError ? error : (output.isEmpty ? '' : output);
    final color = isError ? Appcolor.danger : Appcolor.success;

    if (content.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'Run your code to see the output here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.035),
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.all(Responsive.wp(0.03)),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
        border: Border.all(color: color, width: Responsive.wp(0.002)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.terminal,
                color: color,
                size: Responsive.sp(0.04),
              ),
              SizedBox(width: Responsive.wp(0.015)),
              Text(
                isError ? 'Error' : 'Output',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.sp(0.035),
                ),
              ),
              const Spacer(),
              if (onCopy != null)
                GestureDetector(
                  onTap: onCopy,
                  child: Icon(
                    Icons.copy_rounded,
                    color: color,
                    size: Responsive.sp(0.04),
                  ),
                ),
            ],
          ),
          SizedBox(height: Responsive.hp(0.01)),
          Expanded(
            child: SingleChildScrollView(
              child: SelectableText(
                content,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: Responsive.sp(0.035),
                  fontFamily: isError ? null : 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
