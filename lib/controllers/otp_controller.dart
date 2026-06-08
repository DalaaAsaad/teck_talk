import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class OtpController extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;
  final RxBool isLoading = false.obs;
  final RxBool canResend = false.obs;
  final RxInt resendSeconds = 30.obs;
  final RxString otpCode = ''.obs;
  Timer? countdownTimer;
  late String userEmail = "";
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    _initializeOtpFields();
    userEmail = Get.arguments;
    _startCountdown();
  }

  void _initializeOtpFields() {
    otpControllers = List.generate(6, (_) => TextEditingController());
    otpFocusNodes = List.generate(6, (_) => FocusNode());
  }

  void _startCountdown() {
    canResend.value = false;
    resendSeconds.value = 60;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      resendSeconds.value--;
      if (resendSeconds.value <= 0) {
        canResend.value = true;
        countdownTimer?.cancel();
      }
    });
  }

  void handleOtpInput(int index, String value) {
    if (value.length == 1) {
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        otpFocusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
    _updateOtpCode();
  }

  void _updateOtpCode() {
    otpCode.value = otpControllers.map((controller) => controller.text).join();
  }

  Future<void> verifyOtp() async {
    if (otpCode.value.length != 6) {
      AppSnackBar.error('Please enter all 6 digits');
      return;
    }

    isLoading.value = true;
    try {
      // call backend to verify otp
      final result = await _authRepository.otpSign(
        email: userEmail,
        code: otpCode.value,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (VerifyOtpResponse) async {
          // save token and user info
          await _sharedPrefs.saveAuthToken(VerifyOtpResponse.data.accessToken);
          await _sharedPrefs.saveVerifiedUser(
            fullName: VerifyOtpResponse.data.user.name,
            userName: VerifyOtpResponse.data.user.username,
            email: VerifyOtpResponse.data.user.email,
          );
          print(_sharedPrefs.getUserEmail());
          AppSnackBar.success('Email verified successfully');
          Get.offAllNamed(AppRoutes.mainView);
        },
      );
    } catch (e) {
      AppSnackBar.error('Verification failed. Please try again');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (!canResend.value) {
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await _authRepository.otpResend(email: userEmail);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (OtpResendResponse) {
          _clearOtpFields();
          _startCountdown();
        },
      );
    } catch (e) {
      AppSnackBar.error('Failed to resend code. Try again');
    } finally {
      isLoading.value = false;
    }
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    otpCode.value = '';
    otpFocusNodes[0].requestFocus();
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
