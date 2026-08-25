import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

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
            child: SizedBox(
              height: Responsive.hp(0.062),
              child: OutlinedButton(
                onPressed: () {
                  onSelected(0);
                  onDraft();
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: selectedIndex.value == 0
                      ? Appcolor.accentDim
                      : Colors.transparent,
                  side: BorderSide(
                    color: selectedIndex.value == 0
                        ? Appcolor.accent
                        : Appcolor.panelEdge,
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: CustomText(
                  text: "Save Draft",
                  fontWeight: FontWeight.w600,
                  textColor: selectedIndex.value == 0
                      ? Appcolor.accent
                      : Appcolor.muted,
                ),
              ),
            ),
          ),

          SizedBox(width: Responsive.wp(0.03)),

          Expanded(
            child: SizedBox(
              height: Responsive.hp(0.062),
              child: ElevatedButton(
                onPressed: () {
                  onSelected(1);
                  onPublish();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.accent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: CustomText(
                  text: "Publish",
                  fontWeight: FontWeight.w700,
                  textColor: Appcolor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
