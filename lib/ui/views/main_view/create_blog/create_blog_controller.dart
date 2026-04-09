import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teck_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/selection_topices_dialog.dart';

class CreateBlogController extends GetxController {
  // Text controllers
  final TextEditingController contentController = TextEditingController();

  // Image picker
  final ImagePicker _picker = ImagePicker();

  // Reactive variables for form data
  var selectedLanguage = ''.obs;
  var selectedTopics = <String>[].obs;
  var selectedImages = <XFile>[].obs;
  RxInt selectedIndex = 0.obs;

  // For button color toggle

  // Available options
  final List<String> languages = [
    "Dart",
    "Java",
    "Python",
    "C++",
    "JavaScript",
    "other",
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

  Future<void> pickImages() async {
    PermissionStatus status = await Permission.photos.status;
    if (!status.isGranted) {
      PermissionStatus requestStatus = await Permission.photos.request();
      if (!requestStatus.isGranted) {
        AppSnackBar.error('Cannot access gallery.', title: 'Permission denied');
        return;
      }
    }
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images);
      }
    } catch (e) {
      AppSnackBar.error('Failed to pick images: $e');
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void onCancel() {
    Get.back();
  }

  void showTopicsDialog(BuildContext btnContext) async {
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

  Future<void> postBlog() async {
    if (contentController.text.isEmpty) {
      // Show error message
      AppSnackBar.error('Please enter some content.');
      return;
    }

    try {
      // TODO: Implement API call to post blog
      // await apiService.postBlog(contentController.text, selectedLanguage.value, selectedTopics.toList());

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      AppSnackBar.success('Blog posted successfully!');
      // Reset form
      resetForm();
    } catch (e) {
      AppSnackBar.error('Failed to post blog: $e');
    } finally {}
  }

  Future<void> saveAsDraft() async {
    try {
      // TODO: Implement API call to save draft
      // await apiService.saveDraft(contentController.text, selectedLanguage.value, selectedTopics.toList());

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      AppSnackBar.success('Draft saved successfully!');
    } catch (e) {
      AppSnackBar.error('Failed to save draft: $e');
    } finally {}
  }

  void resetForm() {
    selectedLanguage.value = '';
    selectedTopics.clear();
    selectedImages.clear();
    contentController.clear();
    selectButton(1);
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
