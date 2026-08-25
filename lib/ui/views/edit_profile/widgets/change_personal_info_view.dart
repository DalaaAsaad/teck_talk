import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/change_personal_info_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/glass_input_field.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/elevated_card.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/password_field.dart';

class ChangePersonalInfoView extends GetView<ChangePersonalInfoController> {
  const ChangePersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.hp(0.01)),
                    Container(
                      padding: EdgeInsets.all(Responsive.wp(0.035)),
                      decoration: BoxDecoration(
                        color: Appcolor.accentDim,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Appcolor.accent,
                            size: Responsive.sp(0.045),
                          ),
                          SizedBox(width: Responsive.wp(0.025)),
                          Expanded(
                            child: CustomText(
                              text:
                                  'Changing any of these fields requires your current password to confirm.',
                              styleType: TextStyleType.CUSTOM,
                              textColor: Appcolor.accent,
                              fontSize: Responsive.sp(0.032),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Personal Info',
                      child: Column(
                        children: [
                          GlassInputField(
                            controller: controller.nameController,
                            hintText: 'Full name',
                          ),
                          SizedBox(height: Responsive.hp(0.014)),
                          GlassInputField(
                            controller: controller.usernameController,
                            hintText: 'Username',
                          ),
                          SizedBox(height: Responsive.hp(0.014)),
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GlassInputField(
                                  controller: controller.emailController,
                                  hintText: 'Email',
                                ),
                                if (controller.emailError.value != null) ...[
                                  SizedBox(height: Responsive.hp(0.006)),
                                  Text(
                                    controller.emailError.value!,
                                    style: TextStyle(
                                      color: Appcolor.danger,
                                      fontSize: Responsive.sp(0.03),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.016)),
                    ElevatedCard(
                      title: 'Confirm Password',
                      child: Obx(
                        () => PasswordField(
                          controller: controller.passwordController,
                          hintText: 'Current password',
                          errorText: controller.passwordError.value,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.03)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSaveBar(),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Responsive.wp(0.02),
        end: Responsive.wp(0.045),
        top: Responsive.hp(0.01),
        bottom: Responsive.hp(0.008),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Appcolor.white,
              size: Responsive.sp(0.05),
            ),
          ),
          CustomText(
            text: 'Personal information',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.048),
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveBar() {
    return Container(
      padding: EdgeInsets.only(
        left: Responsive.wp(0.045),
        right: Responsive.wp(0.045),
        top: Responsive.hp(0.014),
        bottom: Responsive.hp(0.024),
      ),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        border: Border(top: BorderSide(color: Appcolor.panelEdge)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: Responsive.hp(0.06),
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: controller.isSaved.value
                ? Container(
                    key: const ValueKey('saved'),
                    decoration: BoxDecoration(
                      color: Appcolor.success.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Appcolor.success.withOpacity(0.4),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_rounded,
                          color: Appcolor.success,
                          size: Responsive.sp(0.045),
                        ),
                        SizedBox(width: Responsive.wp(0.02)),
                        CustomText(
                          text: 'Saved',
                          styleType: TextStyleType.CUSTOM,
                          textColor: Appcolor.success,
                          fontSize: Responsive.sp(0.04),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    key: const ValueKey('save-button'),
                    onPressed: controller.isSaving.value
                        ? null
                        : controller.saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.accent,
                      disabledBackgroundColor: Appcolor.accent.withOpacity(
                        0.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isSaving.value
                        ? SizedBox(
                            width: Responsive.wp(0.05),
                            height: Responsive.wp(0.05),
                            child: const CircularProgressIndicator(
                              color: Appcolor.white,
                              strokeWidth: 2.4,
                            ),
                          )
                        : CustomText(
                            text: 'Save Changes',
                            styleType: TextStyleType.CUSTOM,
                            textColor: Appcolor.white,
                            fontSize: Responsive.sp(0.04),
                            fontWeight: FontWeight.w700,
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
