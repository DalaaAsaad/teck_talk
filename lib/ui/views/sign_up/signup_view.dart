import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/signup_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/orb.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/sign_up/widgets/eye_btn_sign_up.dart';
import 'package:tech_talk/ui/views/sign_up/widgets/field_sign_up.dart';
import 'package:tech_talk/ui/views/sign_up/widgets/header_sign_up.dart';
import 'package:tech_talk/ui/views/sign_up/widgets/name_row_sign_up.dart';
import 'package:tech_talk/ui/views/sign_up/widgets/sign_in_row.dart';
import 'package:tech_talk/ui/views/sign_up/widgets/submit_button_sign_up.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: Stack(
        children: [
          // ── ambient glow top ──────────────────────────────
          Positioned(
            top: -Responsive.height * 0.12,
            left: Responsive.width * 0.1,
            child: Orb(
              size: Responsive.width * 0.85,
              color: Appcolor.accent.withOpacity(0.09),
            ),
          ),

          // ── ambient glow bottom ───────────────────────────
          Positioned(
            bottom: -Responsive.height * 0.08,
            right: -Responsive.width * 0.2,
            child: Orb(
              size: Responsive.width * 0.7,
              color: Appcolor.accent.withOpacity(0.06),
            ),
          ),

          // ── content ───────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.width * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.height * 0.04),
                    HeaderSignUp(),
                    SizedBox(height: Responsive.height * 0.035),
                    NameRowSignUp(controller: controller),
                    SizedBox(height: Responsive.hp(0.014)),
                    FieldSignUp(
                      ctrl: controller.emailController,
                      label: 'Email address',
                      hint: 'you@example.com',
                      icon: Icons.alternate_email_rounded,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(height: Responsive.hp(0.014)),
                    Obx(
                      () => FieldSignUp(
                        ctrl: controller.passwordController,
                        label: 'Password',
                        hint: '••••••••',
                        icon: Icons.lock_outline_rounded,
                        obscure: !controller.showPassword.value,
                        trailing: EyeBtnSignUp(
                          visible: controller.showPassword.value,
                          onTap: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.014)),
                    Obx(
                      () => FieldSignUp(
                        ctrl: controller.confirmPasswordController,
                        label: 'Confirm password',
                        hint: '••••••••',
                        icon: Icons.lock_outline_rounded,
                        obscure: !controller.showConfirmPassword.value,
                        trailing: EyeBtnSignUp(
                          visible: controller.showConfirmPassword.value,
                          onTap: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.height * 0.038),
                    SubmitButtonSignUp(controller: controller),
                    SizedBox(height: Responsive.height * 0.025),
                    SignInRow(),
                    SizedBox(height: Responsive.height * 0.04),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tech_talk/app/my_routs.dart';
// import 'package:tech_talk/controllers/signup_controller.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_button.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_header_section.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_sign_link.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_text_field.dart';
// import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
// import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

// class SignupView extends GetView<SignupController> {
//   const SignupView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Appcolor.black_08,
//         body: Container(
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   AuthHeaderSection(
//                     title: 'Create Your Account',
//                     subtitle: 'Join the TechTalk community today',
//                   ),
//                   SizedBox(height: screenWidth(10)),
//                   _buildBodySignup(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBodySignup() {
//     return Container(
//       height: screenWidth(0.65),
//       padding: EdgeInsetsDirectional.only(
//         top: screenWidth(4),
//         start: screenWidth(20),
//         end: screenWidth(20),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40),
//           topRight: Radius.circular(40),
//         ),
//         color: Appcolor.Black_05,
//       ),
//       child: Column(
//         children: [
//           _buildFormSection(),

//           // Sign Up Button
//           AuthButton(
//             titleButton: 'Sign up',
//             isLoading: controller.isLoading,
//             onTap: controller.signup,
//           ),
//           SizedBox(height: screenWidth(16)),
//           AuthSignLink(
//             questionText: 'You have an account?',
//             linkText: 'Sign in',
//             onTap: () => Get.toNamed(AppRoutes.signin),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFormSection() {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: AuthTextField(
//                   controller: controller.fullNameController,
//                   label: 'Full Name',
//                   hint: 'full name',
//                 ),
//               ),
//               SizedBox(width: screenWidth(20)),
//               Expanded(
//                 child: AuthTextField(
//                   controller: controller.userNameController,
//                   label: 'User Name',
//                   hint: 'User Name',
//                 ),
//               ),
//             ],
//           ),

//           AuthTextField(
//             controller: controller.emailController,
//             label: 'E-mail',
//             hint: 'Enter your email address',

//             keyboardType: TextInputType.emailAddress,
//           ),

//           Obx(
//             () => AuthTextField(
//               controller: controller.passwordController,
//               label: 'Password',
//               hint: 'Enter your password',

//               obscureText: !controller.showPassword.value,
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   controller.showPassword.value
//                       ? Icons.visibility
//                       : Icons.visibility_off,
//                   color: Appcolor.yellow_70,
//                 ),
//                 onPressed: controller.togglePasswordVisibility,
//               ),
//             ),
//           ),

//           // Confirm Password Field
//           Obx(
//             () => AuthTextField(
//               controller: controller.confirmPasswordController,
//               label: 'Confirm Password',
//               hint: 'Confirm your password',

//               obscureText: !controller.showConfirmPassword.value,
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   controller.showConfirmPassword.value
//                       ? Icons.visibility
//                       : Icons.visibility_off,
//                   color: Appcolor.yellow_70,
//                 ),
//                 onPressed: controller.toggleConfirmPasswordVisibility,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
