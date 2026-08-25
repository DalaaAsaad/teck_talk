import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class CreatePostController extends GetxController {
  final TextEditingController contentController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();
  var selectedLanguage = ''.obs;
  var selectedImages = <XFile>[].obs;
  RxInt selectedIndex = 0.obs;
  final RxBool isTagsLoading = false.obs;
  final RxList<Tag> tags = <Tag>[].obs;
  final RxSet<int> selectedTagIds = <int>{}.obs;

  final List<String> languages = [
    "Dart",
    "Java",
    "Python",
    "C++",
    "JavaScript",
    "other",
  ];

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

  void selectButton(int index) {
    selectedIndex.value = index;
  }

  void removeImage(int index, List<XFile> selectedImages) {
    selectedImages.removeAt(index);
  }

  Map<String, String> buildSelectedImageFiles() {
    final Map<String, String> files = {};
    for (int i = 0; i < selectedImages.length; i++) {
      files['photos[$i]'] = selectedImages[i].path;
    }
    return files;
  }

  Map<String, String> buildSelectedTagFields() {
    final Map<String, String> fields = {};
    int i = 0;
    for (final tagId in selectedTagIds) {
      fields['tags[$i]'] = tagId.toString();
      i++;
    }
    return fields;
  }

  Future<void> getTags() async {
    if (isTagsLoading.value) return;
    isTagsLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final result = await _authRepository.getTags(token: token);
      result.fold((failure) => AppSnackBar.error(failure), (response) {
        tags.assignAll(response.data);
      });
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isTagsLoading.value = false;
    }
  }

  void onCancel() {
    Get.back();
  }

  Future<void> creatPost() async {
    if (contentController.text.isEmpty) {
      AppSnackBar.error('Please enter some content.');
      return;
    }
    if (titleController.text.isEmpty) {
      AppSnackBar.error('Please enter a title.');
      return;
    }

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final result = await _authRepository.CreatePost(
        token: token,
        fields: {
          'title': titleController.text,
          'body': contentController.text,
          'code_language': selectedLanguage.value,
          "code": codeController.text,
          "is_published": "1",
          ...buildSelectedTagFields(),
        },
        files: buildSelectedImageFiles(),
      );

      result.fold(
        (failure) => AppSnackBar.error(failure),
        (response) {
          AppSnackBar.success(response.message);
          resetForm();
        },
      );
    } catch (e) {
      AppSnackBar.error('Failed to post blog: $e');
    }
  }

  Future<void> createDraft() async {
    if (contentController.text.isEmpty) {
      AppSnackBar.error('Please enter some content.');
      return;
    }

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final result = await _authRepository.CreatePost(
        token: token,
        fields: {
          'title': contentController.text,
          'body': contentController.text,
          'code_language': selectedLanguage.value,
          "code": codeController.text,
          "is_published": "0",
          ...buildSelectedTagFields(),
        },
        files: buildSelectedImageFiles(),
      );

      result.fold(
        (failure) => AppSnackBar.error(failure),
        (response) {
          AppSnackBar.success(response.message);
          resetForm();
        },
      );
    } catch (e) {
      AppSnackBar.error('Failed to post blog: $e');
    }
  }

  void resetForm() {
    selectedLanguage.value = '';
    selectedTagIds.clear();
    selectedImages.clear();
    titleController.clear();
    contentController.clear();
    codeController.clear();
    selectButton(1);
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    codeController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getTags();
  }
}