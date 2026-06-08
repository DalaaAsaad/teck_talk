import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/selection_topices_dialog.dart';

class CreatePostController extends GetxController {
  // Text controllers
  final TextEditingController contentController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();

  var selectedLanguage = ''.obs;
  var selectedTopics = <String>[].obs;
  var selectedImages = <XFile>[].obs;
  RxInt selectedIndex = 0.obs;

  final RxBool isTagsLoading = false.obs;
  final RxList<Tag> tags = <Tag>[].obs;
  final RxList<String> selectedTopicsDialog = <String>[].obs;

  final List<String> languages = [
    "Dart",
    "Java",
    "Python",
    "C++",
    "JavaScript",
    "other",
  ];
  final List<String> allTopics = [
    "Web",
    "UI/UX",
    "React",
    "JavaScript",
    "Frontend",
    "Flutter",
    "Python",
    "Dart",
  ];
  // Methods
  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

  void toggleTopic(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
  }

  void selectButton(int index) {
    selectedIndex.value = index;
  }

  void removeImage(int index, List<XFile> selectedImages) {
    selectedImages.removeAt(index);
  }

  List<String> get availableTopics {
    if (tags.isNotEmpty) {
      return tags.map((tag) => tag.name).toList();
    }
    return allTopics;
  }

  void openTopicsDialogSelection() {
    selectedTopicsDialog.assignAll(selectedTopics);
  }

  void toggleDialogTopic(String topic) {
    if (selectedTopicsDialog.contains(topic)) {
      selectedTopicsDialog.remove(topic);
    } else {
      selectedTopicsDialog.add(topic);
    }
  }

  void cancelTopicsDialogSelection() {
    selectedTopicsDialog.assignAll(selectedTopics);
    Get.back();
  }

  void submitTopicsDialogSelection() {
    selectedTopics.assignAll(selectedTopicsDialog);
    Get.back(result: selectedTopics.toList());
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
    final selectedTagIds = tags
        .where((tag) => selectedTopics.contains(tag.name))
        .map((tag) => tag.id.toString())
        .toList();

    for (int i = 0; i < selectedTagIds.length; i++) {
      fields['tags[$i]'] = selectedTagIds[i];
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

  void showTopicsDialog(BuildContext btnContext) async {
    openTopicsDialogSelection();
    final List<String>? results = await showDialog(
      context: btnContext,
      builder: (BuildContext context) {
        return MultiSelectTopicesDialog();
      },
    );
    if (results != null) {
      selectedTopics.assignAll(results);
    }
  }

  Future<void> creatPost() async {
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
          "is_published": "1",
          ...buildSelectedTagFields(),
        },
        files: buildSelectedImageFiles(),
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          AppSnackBar.success(response.message);
          resetForm();
        },
      );
    } catch (e) {
      AppSnackBar.error('Failed to post blog: $e');
    } finally {}
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
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          AppSnackBar.success(response.message);
          resetForm();
        },
      );
    } catch (e) {
      AppSnackBar.error('Failed to post blog: $e');
    } finally {}
  }



  void resetForm() {
    selectedLanguage.value = '';
    selectedTopics.clear();
    selectedImages.clear();
    contentController.clear();
    codeController.clear();
    selectButton(1);
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getTags();
  }
}
