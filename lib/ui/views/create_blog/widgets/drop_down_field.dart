import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: Responsive.wp(0.03),
          ),
          child: CustomText(
            text: label,
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.muted,
            fontSize: Responsive.sp(0.032),
            fontWeight: FontWeight.w500,
          ),
        ),

        DropdownMenu<String>(
          width: Responsive.wp(0.45),

          hintText: label,

          textStyle: TextStyle(
            color: Appcolor.white,
            fontSize: Responsive.sp(0.038),
            fontWeight: FontWeight.w600,
          ),

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Appcolor.panel,

            hintStyle: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.038),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
              borderSide: BorderSide(
                color: Appcolor.panelEdge,
                width: Responsive.wp(0.0025),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
              borderSide: BorderSide(
                color: Appcolor.panelEdge,
                width: Responsive.wp(0.0025),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
              borderSide: BorderSide(
                color: Appcolor.accent,
                width: Responsive.wp(0.005),
              ),
            ),
          ),

          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(
              Appcolor.panel,
            ),
            surfaceTintColor: const WidgetStatePropertyAll(
              Colors.transparent,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
                side: BorderSide(
                  color: Appcolor.panelEdge,
                  width: Responsive.wp(0.0025),
                ),
              ),
            ),
            alignment: Alignment.bottomCenter,
          ),

          initialSelection: value,

          onSelected: (String? value) {
            if (value != null) {
              onChanged(value);
            }
          },

          dropdownMenuEntries: items.map<DropdownMenuEntry<String>>(
            (String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(
                    Appcolor.white,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}