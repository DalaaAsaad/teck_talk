import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/app/my_routs.dart';
import 'package:teck_talk/core/data/repository/shared_pref.dart';
import 'package:teck_talk/core/data/repository/auth_repository.dart';
import 'package:teck_talk/ui/shared/shared_widget/app_snackbar.dart';

class SignupController extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final RxBool showPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  Future<void> signup() async {
    if (!_validateForm()) {
      return;
    }

    isLoading.value = true;
    final fullName = fullNameController.text.trim();
    final userName = userNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final passwordConfirmation = confirmPasswordController.text;

    try {
      // Call backend signup
      final authRepo = AuthRepository();
      print(fullName);
      final result = await authRepo.signUp(
        name: fullName,
        email: email,
        username: userName,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      result.fold(
        (error) {
          AppSnackBar.error(error);
        },
        (registerResponse) async {
          // On success, navigate to OTP registration flow

          Get.toNamed(AppRoutes.otp, arguments:  email);
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    if (fullNameController.text.isEmpty) {
      AppSnackBar.error('Full name is required');
      return false;
    }
    if (userNameController.text.isEmpty) {
      AppSnackBar.error('Username is required');
      return false;
    }
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      AppSnackBar.error('Valid email is required');
      return false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      AppSnackBar.error('Password must be at least 6 characters');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      AppSnackBar.error('Passwords do not match');
      return false;
    }

    return true;
  }
}
