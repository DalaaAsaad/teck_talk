import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/otp_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/auth_button.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class OtpRegister extends GetView<OtpController> {
  const OtpRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(18),
                vertical: screenWidth(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenWidth(35)),
                  _buildBackRow(),
                  SizedBox(height: screenWidth(7)),
                  _buildTitleBlock(),
                  SizedBox(height: screenWidth(7)),
                  _buildOtpBoxes(),
                  SizedBox(height: screenWidth(8)),
                  _buildResendSection(),
                  SizedBox(height: screenWidth(2)),
                  _buildVerifyButton(),
                  SizedBox(height: screenWidth(12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackRow() {
    return GestureDetector(
      onTap: controller.goBack,
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: Appcolor.yellow_70,
            size: screenWidth(16),
          ),
          SizedBox(width: screenWidth(35)),
          const CustomText(
            text: 'Back',
            styleType: TextStyleType.CUSTOM,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBlock() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.mail, color: Appcolor.yellow_70, size: screenWidth(8)),
              SizedBox(width: screenWidth(22)),
              CustomText(
                text: 'Verify Your Email',
                styleType: TextStyleType.CUSTOM,
                fontSize: screenWidth(18),
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(height: screenWidth(10)),
          CustomText(
            text: 'We\'ve sent a verification code to:',
            styleType: TextStyleType.CUSTOM,
            fontSize: screenWidth(27),
            textColor: Appcolor.gray_95.withAlpha(220),
          ),
          SizedBox(height: screenWidth(45)),
          CustomText(
            text: controller.userEmail,
            styleType: TextStyleType.CUSTOM,
            fontSize: screenWidth(24),
            fontWeight: FontWeight.w700,
            textColor: Appcolor.yellow_90,
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Container(
          width: screenWidth(10),
          height: screenWidth(10),
          margin: EdgeInsets.symmetric(horizontal: screenWidth(120)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Appcolor.yellow_70, width: 1.2),
          ),
          child: Center(
            child: TextField(
              controller: controller.otpControllers[index],
              focusNode: controller.otpFocusNodes[index],
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: screenWidth(16),
                color: Appcolor.white,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              onChanged: (value) => controller.handleOtpInput(index, value),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResendSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Didn\'t receive the code?',
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(31),
              textColor: Appcolor.gray_95.withAlpha(220),
            ),
            Obx(
              () => GestureDetector(
                onTap: controller.canResend.value ? controller.resendOtp : null,
                child: CustomText(
                  text: 'Resend Code',
                  styleType: TextStyleType.CUSTOM,
                  fontSize: screenWidth(25),
                  fontWeight: FontWeight.w500,
                  textColor: controller.canResend.value
                      ? Appcolor.yellow_70
                      : Appcolor.gray_60,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth(35)),
        Align(
          alignment: Alignment.centerRight,
          child: Obx(
            () => CustomText(
              text:
                  'Resend available in 00:${controller.resendSeconds.value.toString().padLeft(2, '0')}',
              styleType: TextStyleType.CUSTOM,
              fontSize: screenWidth(35),
              textColor: Appcolor.gray_95.withAlpha(220),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return AuthButton(
      titleButton: 'Verify Account',
      isLoading: controller.isLoading,
      onTap: controller.verifyOtp,
    );
  }
}
