import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/app/my_routs.dart';
import 'package:teck_talk/controllers/signup_controller.dart';
import 'package:teck_talk/ui/shared/custom_widget/auth_button.dart';
import 'package:teck_talk/ui/shared/custom_widget/auth_header_section.dart';
import 'package:teck_talk/ui/shared/custom_widget/auth_sign_link.dart';
import 'package:teck_talk/ui/shared/custom_widget/auth_text_field.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

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
                    title: 'Create Your Account',
                    subtitle: 'Join the TechTalk community today',
                  ),
                  SizedBox(height: screenWidth(10)),
                  _buildBodySignup(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodySignup() {
    return Container(
      height: screenWidth(0.65),
      padding: EdgeInsetsDirectional.only(
        top: screenWidth(4),
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

          // Sign Up Button
          AuthButton(
            titleButton: 'Sign up',
            isLoading: controller.isLoading,
            onTap: controller.signup,
          ),
          SizedBox(height: screenWidth(16)),
          AuthSignLink(
            questionText: 'You have an account?',
            linkText: 'Sign in',
            onTap: () => Get.toNamed(AppRoutes.signin),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AuthTextField(
                  controller: controller.fullNameController,
                  label: 'Full Name',
                  hint: 'full name',
                ),
              ),
              SizedBox(width: screenWidth(20)),
              Expanded(
                child: AuthTextField(
                  controller: controller.userNameController,
                  label: 'User Name',
                  hint: 'User Name',
                ),
              ),
            ],
          ),

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

          // Confirm Password Field
          Obx(
            () => AuthTextField(
              controller: controller.confirmPasswordController,
              label: 'Confirm Password',
              hint: 'Confirm your password',

              obscureText: !controller.showConfirmPassword.value,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.showConfirmPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Appcolor.yellow_70,
                ),
                onPressed: controller.toggleConfirmPasswordVisibility,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
