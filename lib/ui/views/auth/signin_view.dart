import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/signin_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/auth_button.dart';
import 'package:tech_talk/ui/shared/custom_widget/auth_header_section.dart';
import 'package:tech_talk/ui/shared/custom_widget/auth_sign_link.dart';
import 'package:tech_talk/ui/shared/custom_widget/auth_text_field.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  AuthHeaderSection(
                    title: 'Welcome Back',
                    subtitle: 'sign in to continue to TechTalk',
                  ),
                  SizedBox(height: screenWidth(10)),
                  _buildBodySignin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodySignin() {
    return Container(
      height: screenWidth(0.65),
      padding: EdgeInsetsDirectional.only(
        top: screenWidth(2.5),
        start: screenWidth(20),
        end: screenWidth(20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: Appcolor.Black_05,
      ),
      child: Column(
        children: [
          _buildFormSection(),

          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => GestureDetector(
                onTap: controller.isForgetPasswordLoading.value
                    ? null
                    : controller.forgetPassword,
                child: controller.isForgetPasswordLoading.value
                    ? SizedBox(
                        width: screenWidth(28),
                        height: screenWidth(28),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Appcolor.yellow_70,
                        ),
                      )
                    : CustomText(
                        text: 'Forgot Password ?',
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.yellow_70,
                        fontSize: screenWidth(30),
                        fontWeight: FontWeight.w400,
                      ),
              ),
            ),
          ),
          SizedBox(height: screenWidth(6)),
          // Sign In Button
          AuthButton(
            titleButton: 'Sign in',
            isLoading: controller.isLoading,
            onTap: controller.signin,
          ),
          SizedBox(height: screenWidth(10)),
          AuthSignLink(
            questionText: 'Don\'t have an account?',
            linkText: 'Sign up',
            onTap: controller.goToSignup,
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      child: Column(
        children: [
          AuthTextField(
            controller: controller.emailController,
            label: 'E-mail',
            hint: 'Enter your email address',

            keyboardType: TextInputType.emailAddress,
          ),

          Obx(
            () => AuthTextField(
              controller: controller.passwordController,
              label: 'Password',
              hint: 'Enter your password',

              obscureText: !controller.showPassword.value,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.showPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Appcolor.yellow_70,
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
