import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/create_post/widgets/section_header.dart';
import 'package:teck_talk/controllers/create_post_controller.dart';

class CodeSection extends GetView<CreatePostController> {
  const CodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Code"),
        SizedBox(height: screenWidth(25)),
        _buildLanguageSelector(),
        SizedBox(height: screenWidth(40)),
        _buildCodeInputBox(),
      ],
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [_buildLanguageDropdown()],
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownMenu<String>(
      width: screenWidth(1.7),
      hintText: "Select Language",
      textStyle: TextStyle(
        color: Appcolor.black_08,
        fontSize: screenWidth(20),
        fontWeight: FontWeight.w600,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Appcolor.yellow_70,
        hintStyle: TextStyle(
          color: Appcolor.black_08,
          fontSize: screenWidth(21),
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
      initialSelection: controller.selectedLanguage.value,
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
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCodeInputBox() {
    return Container(
      height: screenWidth(2),
      decoration: BoxDecoration(
        border: Border.all(color: Appcolor.yellow_70),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.all(screenWidth(51)),
        child: TextField(
          controller: controller.codeController,
          maxLines: null,
          style: TextStyle(color: Appcolor.white),
          decoration: InputDecoration(
            hintText: "Paste your code here...",
            hintStyle: TextStyle(color: Appcolor.white.withAlpha(200)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
