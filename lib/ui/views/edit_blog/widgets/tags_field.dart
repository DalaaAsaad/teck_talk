import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// حقل بيعرض التاغز المختارة كـ chips، وبفتح الـ Bottom Sheet لما تدوس
/// عليه. لما ما يكون في تاغز مختارة، بيبيّن حالة فاضية "Add tags".
class TagsField extends StatelessWidget {
  final List<String> selectedTagNames;
  final VoidCallback onTap;

  const TagsField({
    super.key,
    required this.selectedTagNames,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: Responsive.hp(0.06)),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.wp(0.035),
          vertical: Responsive.hp(0.012),
        ),
        decoration: BoxDecoration(
          color: Appcolor.bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Appcolor.panelEdge),
        ),
        child: selectedTagNames.isEmpty
            ? Row(
                children: [
                  Icon(
                    Icons.local_offer_outlined,
                    color: Appcolor.muted,
                    size: Responsive.sp(0.045),
                  ),
                  SizedBox(width: Responsive.wp(0.02)),
                  CustomText(
                    text: 'Add tags',
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.muted,
                    fontSize: Responsive.sp(0.037),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.add_rounded,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.05),
                  ),
                ],
              )
            : Wrap(
                spacing: Responsive.wp(0.02),
                runSpacing: Responsive.hp(0.01),
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ...selectedTagNames.map(
                    (name) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.wp(0.03),
                        vertical: Responsive.hp(0.007),
                      ),
                      decoration: BoxDecoration(
                        color: Appcolor.accentDim,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomText(
                        text: name,
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.accent,
                        fontSize: Responsive.sp(0.032),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: Responsive.wp(0.07),
                    height: Responsive.wp(0.07),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Appcolor.panelEdge),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      color: Appcolor.accent,
                      size: Responsive.sp(0.04),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
