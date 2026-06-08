import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class PublishDraftButtonWidget extends StatelessWidget {
  final VoidCallback onDraft;
  final VoidCallback onPublish;
  final Function(int) onSelected;
  final RxInt selectedIndex;

  const PublishDraftButtonWidget({
    super.key,
    required this.onDraft,
    required this.onPublish,
    required this.onSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                onSelected(0);
                onDraft();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedIndex.value == 0
                    ? Appcolor.yellow_70
                    : null,

                side: BorderSide(color: Appcolor.yellow_70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: CustomText(
                text: "Save Draft",
                textColor: selectedIndex.value == 0
                    ? Colors.black
                    : Appcolor.white,
              ),
            ),
          ),

          SizedBox(width: screenWidth(40)),

          Expanded(
            child: ElevatedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: selectedIndex.value == 1
                    ? Appcolor.yellow_70
                    : Appcolor.black_08,

                side: BorderSide(color: Appcolor.yellow_70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                onPublish();
                onSelected(1);
              },
              child: CustomText(
                text: "Publish",
                textColor: selectedIndex.value == 1
                    ? Appcolor.black_08
                    : Appcolor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
