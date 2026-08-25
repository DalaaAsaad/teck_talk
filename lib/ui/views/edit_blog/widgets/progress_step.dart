import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// شريط تقدم بيتحدث حسب [currentStep] اللي بيحسبه الكونترولر بناءً على
/// اكتمال الحقول (مش بناءً على مكان السكرول - أأمن وبلا أي تصادم مع
/// إعادة بناء Obx).
class ProgressSteps extends StatelessWidget {
  final List<String> steps;
  final RxInt currentStep;

  const ProgressSteps({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(steps.length, (i) {
              final isDone = i <= currentStep.value;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: i == steps.length - 1 ? 0 : Responsive.wp(0.015),
                  ),
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDone ? Appcolor.accent : Appcolor.panelEdge,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: Responsive.hp(0.008)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (i) {
              final isDone = i <= currentStep.value;
              return CustomText(
                text: steps[i],
                styleType: TextStyleType.CUSTOM,
                textColor: isDone ? Appcolor.accent : Appcolor.muted,
                fontSize: Responsive.sp(0.028),
                fontWeight: FontWeight.w600,
              );
            }),
          ),
        ],
      ),
    );
  }
}