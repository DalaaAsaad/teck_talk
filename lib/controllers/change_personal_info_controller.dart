import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class ChangePersonalInfoController extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController usernameController;
  final TextEditingController passwordController = TextEditingController();

  late final String _originalName;
  late final String _originalEmail;
  late final String _originalUsername;

  final RxBool isSaving = false.obs;
  final RxBool isSaved = false.obs;
  final RxnString passwordError = RxnString();
  final RxnString emailError = RxnString();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    final map = args is Map ? args : const {};

    final argName = map['name']?.toString() ?? '';
    final argEmail = map['email']?.toString() ?? '';
    final argUsername = map['username']?.toString() ?? '';

    _originalName = argName.isNotEmpty
        ? argName
        : (_sharedPrefs.getUserFullName() ?? '');
    _originalEmail = argEmail.isNotEmpty
        ? argEmail
        : (_sharedPrefs.getUserEmail() ?? '');
    _originalUsername = argUsername.isNotEmpty
        ? argUsername
        : (_sharedPrefs.getUserUserName() ?? '');

    nameController = TextEditingController(text: _originalName);
    emailController = TextEditingController(text: _originalEmail);
    usernameController = TextEditingController(text: _originalUsername);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool get hasChanges =>
      nameController.text.trim() != _originalName ||
      emailController.text.trim() != _originalEmail ||
      usernameController.text.trim() != _originalUsername;

  bool _isValidEmail(String value) {
    return RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\.\-]+$').hasMatch(value);
  }

  /// لو الخطأ متعلق بكلمة المرور، وريها تحت حقل الباسورد مباشرة بدل
  /// Snackbar عام - أوضح للمستخدم شو بالضبط غلط.
  void _handleFieldError(String error) {
    if (error.toLowerCase().contains('password')) {
      passwordError.value = error;
    } else {
      AppSnackBar.error(error);
    }
  }

  Future<void> saveChanges() async {
    passwordError.value = null;
    emailError.value = null;

    if (!hasChanges) {
      AppSnackBar.error('Change at least one field first');
      return;
    }

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || username.isEmpty) {
      AppSnackBar.error('All fields are required');
      return;
    }

    final nameChanged = name != _originalName;
    final usernameChanged = username != _originalUsername;
    final emailChanged = email != _originalEmail;

    if (emailChanged && !_isValidEmail(email)) {
      emailError.value = 'Enter a valid email address';
      return;
    }

    if (password.isEmpty) {
      passwordError.value = 'Enter your password to confirm';
      return;
    }

    isSaving.value = true;

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      bool hadError = false;

      if (nameChanged) {
        final result = await _authRepository.changeName(
          name: name,
          password: password,
          token: token,
        );
        result.fold((error) {
          hadError = true;
          _handleFieldError(error);
        }, (_) {});
      }

      if (!hadError && usernameChanged) {
        final result = await _authRepository.updateUsername(
          username: username,
          password: password,
          token: token,
        );
        result.fold((error) {
          hadError = true;
          _handleFieldError(error);
        }, (_) {});
      }

      if (!hadError && emailChanged) {
        final result = await _authRepository.updateEmail(
          email: email,
          password: password,
          token: token,
        );
        result.fold((error) {
          hadError = true;
          _handleFieldError(error);
        }, (_) {});
      }

      if (!hadError) {
        _onSaveSuccess();
      }
    } catch (e) {
      AppSnackBar.error('Something went wrong');
    } finally {
      isSaving.value = false;
    }
  }

  void _onSaveSuccess() async {
    isSaved.value = true;
    passwordController.clear();

    await Future.delayed(const Duration(milliseconds: 700));

    AppSnackBar.success('Personal information updated successfully');

    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().loadProfile();
    }

    Get.back(result: true);
  }
}
