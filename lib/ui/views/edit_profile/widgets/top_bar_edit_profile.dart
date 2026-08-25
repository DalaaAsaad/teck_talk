import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class TopBarEditProfile extends StatelessWidget {
  final bool isOnboarding;
  final bool isSaving;
  final bool isSaved;
  final VoidCallback onSave;

  const TopBarEditProfile({
    super.key,
    required this.isOnboarding,
    required this.isSaving,
    required this.onSave,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: isOnboarding ? Responsive.wp(0.045) : Responsive.wp(0.02),
        end: Responsive.wp(0.045),
        top: Responsive.hp(0.01),
        bottom: Responsive.hp(0.008),
      ),
      child: Row(
        children: [
          if (!isOnboarding)
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Appcolor.white,
                size: Responsive.sp(0.05),
              ),
            ),
          CustomText(
            text: isOnboarding ? 'Complete your profile' : 'Edit Profile',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.05),
            fontWeight: FontWeight.w700,
          ),
          const Spacer(),
          SizedBox(
            height: Responsive.hp(0.045),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: isSaved
                  ? _SavedBadge(key: const ValueKey('saved'))
                  : ElevatedButton(
                      key: const ValueKey('save-button'),
                      onPressed: isSaving ? null : onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.accent,
                        disabledBackgroundColor: Appcolor.accent.withOpacity(
                          0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.wp(0.045),
                        ),
                        elevation: 0,
                      ),
                      child: isSaving
                          ? SizedBox(
                              width: Responsive.wp(0.04),
                              height: Responsive.wp(0.04),
                              child: const CircularProgressIndicator(
                                color: Appcolor.white,
                                strokeWidth: 2.2,
                              ),
                            )
                          : CustomText(
                              text: isOnboarding ? 'Continue' : 'Save',
                              styleType: TextStyleType.CUSTOM,
                              textColor: Appcolor.white,
                              fontSize: Responsive.sp(0.036),
                              fontWeight: FontWeight.w700,
                            ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedBadge extends StatelessWidget {
  const _SavedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.04),
        vertical: Responsive.hp(0.01),
      ),
      decoration: BoxDecoration(
        color: Appcolor.success.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.success.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_rounded,
            color: Appcolor.success,
            size: Responsive.sp(0.04),
          ),
          SizedBox(width: Responsive.wp(0.015)),
          CustomText(
            text: 'Saved',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.success,
            fontSize: Responsive.sp(0.036),
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
