import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/app/my_routs.dart';
import 'package:teck_talk/core/data/repository/auth_repository.dart';
import 'package:teck_talk/core/data/repository/shared_pref.dart';
import 'package:teck_talk/ui/shared/shared_widget/app_snackbar.dart';

class SigninController extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final RxBool showPassword = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isForgetPasswordLoading = false.obs;
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  Future<void> signin() async {
    if (!_validateForm()) {
      return;
    }

    isLoading.value = true;
    try {
      final result = await _authRepository.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (signInResponse) async {
          await _sharedPrefs.setLoggedIn(true);
          await _sharedPrefs.saveAuthToken(signInResponse.data.accessToken);
          await _sharedPrefs.saveVerifiedUser(
            fullName: signInResponse.data.user.name,
            userName: signInResponse.data.user.username,
            email: signInResponse.data.user.email,
          );
          Get.offAllNamed('/mainView');
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error('An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgetPassword() async {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      AppSnackBar.error('Valid email is required');
      return;
    }

    isForgetPasswordLoading.value = true;
    try {
      final result = await _authRepository.forgetPassword(
        email: emailController.text.trim(),
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (forgetPasswordResponse) async {
          AppSnackBar.success(
            title: "Check your email",
            forgetPasswordResponse.message,
          );
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error('An error occurred');
    } finally {
      isForgetPasswordLoading.value = false;
    }
  }

  bool _validateForm() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      AppSnackBar.error('Valid email is required');
      return false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      AppSnackBar.error('Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  void goToSignup() {
    Get.toNamed(AppRoutes.signup);
  }
}
