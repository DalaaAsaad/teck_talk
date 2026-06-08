import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
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
          padding: EdgeInsetsDirectional.only(bottom: screenWidth(22)),
          child: CustomText(
            text: label,
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.gray_60,
            fontSize: screenWidth(30),
            fontWeight: FontWeight.w500,
          ),
        ),
        DropdownMenu<String>(
          width: screenWidth(2),
          hintText: label,
          textStyle: TextStyle(
            color: Appcolor.black_08,
            fontSize: screenWidth(30),
            fontWeight: FontWeight.w600,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Appcolor.white,
            hintStyle: TextStyle(
              color: Appcolor.black_08,
              fontSize: screenWidth(30),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Appcolor.yellow_70),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Appcolor.yellow_70),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Appcolor.yellow_70, width: 2),
            ),
          ),
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Appcolor.gray_60),
            alignment: Alignment.bottomCenter,
          ),
          initialSelection: value,
          onSelected: (String? value) {
            if (value != null) {
              onChanged(value);
            }
          },

          dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((
            String value,
          ) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
