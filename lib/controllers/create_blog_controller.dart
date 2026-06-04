import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teck_talk/ui/shared/shared_widget/app_snackbar.dart';

class CreateBlogController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  final RxList<XFile> selectedImages = <XFile>[].obs;
  final RxList<String> sections = <String>['Introduction'].obs;

  final RxString selectedCategory = 'Design'.obs;
  final RxString selectedReadingTime = '10 min'.obs;
  final RxInt selectedIndex = (-1).obs;
  final RxSet<int> editingIndices = <int>{}.obs;

  final List<String> categories = ['Design', 'Technology', 'AI', 'Education'];
  final List<String> readingTimes = ['3 min', '5 min', '10 min', '15 min'];

  final List<TextEditingController> sectionControllers =
      <TextEditingController>[];
  final List<TextEditingController> sectionContentControllers =
      <TextEditingController>[];

  @override
  void onInit() {
    super.onInit();
    _syncSectionControllers();
  }

  @override
  void onClose() {
    titleController.dispose();
    subtitleController.dispose();
    for (final controller in sectionControllers) {
      controller.dispose();
    }
    for (final controller in sectionContentControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void cancel() {
    Get.back();
  }

  void selectCategory(String value) {
    selectedCategory.value = value;
  }

  void selectReadingTime(String value) {
    selectedReadingTime.value = value;
  }

  void selectButton(int index) {
    selectedIndex.value = index;
  }

  void startEditSection(int index) {
    editingIndices.add(index);
    sectionControllers[index].text = sections[index];
  }

  void saveSectionTitle(int index) {
    final text = sectionControllers[index].text.trim();
    if (text.isEmpty) {
      AppSnackBar.error('Section title cannot be empty');
      return;
    }

    sections[index] = text;
    editingIndices.remove(index);
  }

  void cancelEditSection(int index) {
    sectionControllers[index].text = sections[index];
    editingIndices.remove(index);
  }

  void deleteSection(int index) {
    if (index < 0 || index >= sections.length) {
      return;
    }

    editingIndices.remove(index);
    sections.removeAt(index);
    sectionControllers.removeAt(index).dispose();
    sectionContentControllers.removeAt(index).dispose();
  }

  void addSection() {
    final newSectionIndex = sections.length + 1;
    sections.add('New section $newSectionIndex');
    sectionControllers.add(
      TextEditingController(text: 'New section $newSectionIndex'),
    );
    sectionContentControllers.add(TextEditingController());
    editingIndices.add(sections.length - 1);
  }

  Future<void> saveDraft() async {
    if (!_validateForm()) {
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 1));
      AppSnackBar.success('Draft saved successfully');
    } catch (e) {
      AppSnackBar.error('Failed to save draft');
    }
  }

  Future<void> publishBlog() async {
    if (!_validateForm()) {
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));
      AppSnackBar.success('Blog published successfully');
      resetForm();
    } catch (e) {
      AppSnackBar.error('Failed to publish blog');
    }
  }

  void resetForm() {
    titleController.clear();
    subtitleController.clear();
    selectedImages.clear();
    selectedCategory.value = categories.first;
    selectedReadingTime.value = readingTimes[2];
    selectedIndex.value = -1;

    for (final controller in sectionContentControllers) {
      controller.clear();
    }
  }

  bool _validateForm() {
    if (titleController.text.trim().isEmpty) {
      AppSnackBar.error('Article title is required');
      return false;
    }

    if (subtitleController.text.trim().isEmpty) {
      AppSnackBar.error('Article subtitle is required');
      return false;
    }

    if (selectedImages.isEmpty) {
      AppSnackBar.error('Please add a cover image');
      return false;
    }

    for (int i = 0; i < sectionContentControllers.length; i++) {
      if (sectionContentControllers[i].text.trim().isEmpty) {
        AppSnackBar.error('Content for "${sections[i]}" section is required');
        return false;
      }
    }

    return true;
  }

  void _syncSectionControllers() {
    for (final controller in sectionControllers) {
      controller.dispose();
    }
    for (final controller in sectionContentControllers) {
      controller.dispose();
    }

    sectionControllers.clear();
    sectionContentControllers.clear();

    for (final section in sections) {
      sectionControllers.add(TextEditingController(text: section));
      sectionContentControllers.add(TextEditingController());
    }
  }
}
