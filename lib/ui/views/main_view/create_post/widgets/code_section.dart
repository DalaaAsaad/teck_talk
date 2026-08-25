import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/elevated_card.dart';

class CodeSection extends GetView<CreatePostController> {
  const CodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      title: "Code",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLanguageDropdown(),
          SizedBox(height: Responsive.hp(0.016)),
          _buildCodeInputBox(),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownMenu<String>(
      width: Responsive.wp(0.45),
      hintText: "Select Language",
      textStyle: TextStyle(
        color: Appcolor.white,
        fontSize: Responsive.sp(0.036),
        fontWeight: FontWeight.w600,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Appcolor.bg,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Responsive.wp(0.03),
          vertical: Responsive.hp(0.01),
        ),
        hintStyle: TextStyle(
          color: Appcolor.muted,
          fontSize: Responsive.sp(0.036),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Appcolor.panelEdge),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Appcolor.panelEdge),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Appcolor.accent, width: 1.4),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Appcolor.panel),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(6),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Appcolor.panelEdge),
          ),
        ),
      ),
      initialSelection: controller.selectedLanguage.value.isEmpty
          ? null
          : controller.selectedLanguage.value,
      onSelected: (String? value) {
        if (value != null) {
          controller.selectLanguage(value);
        }
      },
      dropdownMenuEntries: controller.languages.map<DropdownMenuEntry<String>>((
        String value,
      ) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Appcolor.white),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCodeInputBox() {
    return Container(
      height: Responsive.hp(0.22),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.032),
        vertical: Responsive.hp(0.012),
      ),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        border: Border.all(color: Appcolor.panelEdge),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller.codeController,
        maxLines: null,
        style: TextStyle(
          color: Appcolor.white,
          fontFamily: 'monospace',
          fontSize: Responsive.sp(0.036),
        ),
        decoration: InputDecoration(
          hintText: "Paste your code here...",
          hintStyle: TextStyle(color: Appcolor.muted),
          border: InputBorder.none,
        ),
      ),
    );
  }
}