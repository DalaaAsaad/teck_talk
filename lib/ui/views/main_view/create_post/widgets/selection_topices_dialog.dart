import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class MultiSelectTopicesDialog extends GetView<CreatePostController> {
  const MultiSelectTopicesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Appcolor.gray_95,
      title: CustomText(
        text: 'Select Topics',
        styleType: TextStyleType.SUBTITLE,
        textColor: Appcolor.dark_20,
      ),
      content: SizedBox(
        height: screenWidth(1.2),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.availableTopics.length,
            itemBuilder: (context, index) {
              final topic = controller.availableTopics[index];
              return Obx(
                () => CheckboxListTile(
                  fillColor: const WidgetStatePropertyAll(Appcolor.white),
                  checkColor: Appcolor.black_08,
                  title: Text(topic),
                  value: controller.selectedTopicsDialog.contains(topic),
                  onChanged: (value) {
                    controller.toggleDialogTopic(topic);
                  },
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: controller.cancelTopicsDialogSelection,
          child: CustomText(
            text: 'Cancel',
            styleType: TextStyleType.BODY,
            textColor: Appcolor.dark_20,
          ),
        ),
        TextButton(
          onPressed: controller.submitTopicsDialogSelection,
          child: CustomText(
            text: 'Submit',
            styleType: TextStyleType.BODY,
            textColor: Appcolor.dark_20,
          ),
        ),
      ],
    );
  }
}
