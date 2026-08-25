import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/signin_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/orb.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/sign_in/widgets/eye_btn_sign_in.dart';
import 'package:tech_talk/ui/views/sign_in/widgets/field_sign_in.dart';
import 'package:tech_talk/ui/views/sign_in/widgets/header_sign_in.dart';
import 'package:tech_talk/ui/views/sign_in/widgets/sign_up_row.dart';
import 'package:tech_talk/ui/views/sign_in/widgets/submit_button_sign_in.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

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
                    SizedBox(height: Responsive.height * 0.05),
                    HeaderSignIn(),
                    SizedBox(height: Responsive.height * 0.045),

                    // Email
                    FieldSignIn(
                      ctrl: controller.emailController,
                      label: 'Email address',
                      hint: 'you@example.com',
                      icon: Icons.alternate_email_rounded,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),

                    // Password
                    Obx(
                      () => FieldSignIn(
                        ctrl: controller.passwordController,
                        label: 'Password',
                        hint: '••••••••',
                        icon: Icons.lock_outline_rounded,
                        obscure: !controller.showPassword.value,
                        trailing: EyeBtnSignIn(
                          visible: controller.showPassword.value,
                          onTap: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.014)),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: Obx(
                        () => GestureDetector(
                          onTap: controller.isForgetPasswordLoading.value
                              ? null
                              : controller.forgetPassword,
                          child: controller.isForgetPasswordLoading.value
                              ? SizedBox(
                                  width: Responsive.wp(0.04),
                                  height: Responsive.hp(0.02),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Appcolor.accent,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.wp(0.02),
                                    vertical: Responsive.hp(0.004),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Appcolor.accentDim,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: Appcolor.accent,
                                      fontSize: Responsive.sp(0.035),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: Responsive.height * 0.042),
                    SubmitButtonSignIn(controller: controller),
                    SizedBox(height: Responsive.height * 0.025),
                    SignUpRow(controller: controller),
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

// ─────────────────────────────────────────────
//  Header
// ─────────────────────────────────────────────


// ─────────────────────────────────────────────
//  Animated text field
// ─────────────────────────────────────────────


// ─────────────────────────────────────────────
//  Eye icon button
// ─────────────────────────────────────────────

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tech_talk/controllers/signin_controller.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_button.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_header_section.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_sign_link.dart';
// import 'package:tech_talk/ui/shared/custom_widget/auth_text_field.dart';
// import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
// import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
// import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

// class SigninView extends GetView<SigninController> {
//   const SigninView({super.key});

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
//                     title: 'Welcome Back',
//                     subtitle: 'sign in to continue to TechTalk',
//                   ),
//                   SizedBox(height: screenWidth(10)),
//                   _buildBodySignin(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBodySignin() {
//     return Container(
//       height: screenWidth(0.65),
//       padding: EdgeInsetsDirectional.only(
//         top: screenWidth(2.5),
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

//           Align(
//             alignment: Alignment.centerRight,
//             child: Obx(
//               () => GestureDetector(
//                 onTap: controller.isForgetPasswordLoading.value
//                     ? null
//                     : controller.forgetPassword,
//                 child: controller.isForgetPasswordLoading.value
//                     ? SizedBox(
//                         width: screenWidth(28),
//                         height: screenWidth(28),
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Appcolor.yellow_70,
//                         ),
//                       )
//                     : CustomText(
//                         text: 'Forgot Password ?',
//                         styleType: TextStyleType.CUSTOM,
//                         textColor: Appcolor.yellow_70,
//                         fontSize: screenWidth(30),
//                         fontWeight: FontWeight.w400,
//                       ),
//               ),
//             ),
//           ),
//           SizedBox(height: screenWidth(6)),
//           // Sign In Button
//           AuthButton(
//             titleButton: 'Sign in',
//             isLoading: controller.isLoading,
//             onTap: controller.signin,
//           ),
//           SizedBox(height: screenWidth(10)),
//           AuthSignLink(
//             questionText: 'Don\'t have an account?',
//             linkText: 'Sign up',
//             onTap: controller.goToSignup,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFormSection() {
//     return Container(
//       child: Column(
//         children: [
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
//         ],
//       ),
//     );
//   }
// }
