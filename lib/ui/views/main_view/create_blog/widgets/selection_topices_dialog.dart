import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class MultiSelectTopicesDialog extends StatefulWidget {
  MultiSelectTopicesDialog({super.key});

  @override
  State<MultiSelectTopicesDialog> createState() =>
      _MultiSelectTopicesDialogState();
}

class _MultiSelectTopicesDialogState extends State<MultiSelectTopicesDialog> {
  final List<String> allTopics = [
    "Web",
    "UI/UX",
    "React",
    "JavaScript",
    "Frontend",
    "Flutter",
    "Python",
    "Dart",
  ];
  final List<String> _selectedTopics = [];
  void itemChange(String topic, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedTopics.add(topic);
      } else {
        _selectedTopics.remove(topic);
      }
    });
  }

  void cancel() {
    Navigator.pop(context);
  }

  void submit() {
    Navigator.pop(context, _selectedTopics);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Appcolor.gray_95,
      title: CustomText(
        text: "Select Topics",
        styleType: TextStyleType.SUBTITLE,
        textColor: Appcolor.dark_20,
      ),
      content: SizedBox(
        height: screenWidth(1.2),
        child: ListView.builder(
          itemCount: allTopics.length,
          itemBuilder: (context, index) {
            final topic = allTopics[index];
            return CheckboxListTile(
              fillColor: WidgetStatePropertyAll(Appcolor.black_08),

              checkColor: Appcolor.white,
              title: Text(topic),
              value: _selectedTopics.contains(topic),
              onChanged: (value) => itemChange(topic, value ?? false),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: cancel,
          child: CustomText(
            text: "Cancel",
            styleType: TextStyleType.BODY,
            textColor: Appcolor.dark_20,
          ),
        ),
        TextButton(
          onPressed: submit,
          child: CustomText(
            text: "Submit",
            styleType: TextStyleType.BODY,
            textColor: Appcolor.dark_20,
          ),
        ),
      ],
    );
  }
}
