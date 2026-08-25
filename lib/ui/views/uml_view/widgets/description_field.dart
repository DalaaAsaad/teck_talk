import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.textController,
    required this.maxLength,
    required this.isLoading,
    required this.onChanged,
  });

  final TextEditingController textController;
  final int maxLength;
  final bool isLoading;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.sp(0.025)),
        border: Border.all(
          color: Appcolor.panelEdge,
          width: Responsive.sp(0.002),
        ),
      ),
      child: Stack(
        children: [
          TextField(
            controller: textController,
            maxLength: maxLength,
            maxLines: null,
            expands: true,
            enabled: !isLoading,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.035),
              height: 1.5,
            ),
            onChanged: onChanged,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText:
                  'Describe your system in plain text\n\n'
                  'Example: A user can login and browse\n'
                  'products. Admin can manage inventory\n'
                  'and view orders...',
              hintStyle: TextStyle(
                color: Appcolor.muted,
                fontSize: Responsive.sp(0.033),
                height: 1.5,
              ),
              counterText: '',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(Responsive.sp(0.04)),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(Responsive.sp(0.025)),
                ),
                child: Center(
                  child: SizedBox(
                    width: Responsive.sp(0.06),
                    height: Responsive.sp(0.06),
                    child: CircularProgressIndicator(
                      color: Appcolor.accent,
                      strokeWidth: Responsive.sp(0.004),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}