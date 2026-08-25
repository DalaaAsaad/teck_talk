import 'package:flutter/material.dart';
import 'package:tech_talk/controllers/signup_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/views/sign_up/widgets/field_sign_up.dart';

class NameRowSignUp extends StatelessWidget {
  final SignupController controller;
  const NameRowSignUp({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FieldSignUp(
            ctrl: controller.fullNameController,
            label: 'Full name',
            hint: 'John Doe',
            icon: Icons.person_outline_rounded,
          ),
        ),
        SizedBox(width: Responsive.wp(0.022)),
        Expanded(
          child: FieldSignUp(
            ctrl: controller.userNameController,
            label: 'Username',
            hint: '@handle',
            icon: Icons.badge_outlined,
          ),
        ),
      ],
    );
  }
}
