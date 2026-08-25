import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class SegmentedOption {
  final String value;
  final String label;
  final IconData? icon;

  const SegmentedOption({required this.value, required this.label, this.icon});
}

class SegmentedSelector extends StatelessWidget {
  final List<SegmentedOption> options;
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final bool isSaving;

  const SegmentedSelector({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.isSaving = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.wp(0.008)),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = option.value == selectedValue;
          return Expanded(
            child: GestureDetector(
              onTap: isSaving ? null : () => onChanged(option.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.011)),
                decoration: BoxDecoration(
                  color: isSelected ? Appcolor.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(Responsive.wp(0.022)),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (option.icon != null) ...[
                      Icon(
                        option.icon,
                        size: Responsive.sp(0.036),
                        color: isSelected ? Appcolor.white : Appcolor.muted,
                      ),
                      SizedBox(width: Responsive.wp(0.012)),
                    ],
                    CustomText(
                      text: option.label,
                      styleType: TextStyleType.CUSTOM,
                      textColor: isSelected ? Appcolor.white : Appcolor.muted,
                      fontSize: Responsive.sp(0.033),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
