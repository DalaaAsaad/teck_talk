import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart' as tags;
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class CreateBlogController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _blogRepository = AuthRepository();

  final ImagePicker _picker = ImagePicker();

  final RxList<XFile> selectedImages = <XFile>[].obs;
  final RxList<String> sections = <String>['Introduction'].obs;

  final RxString selectedReadingTime = '10 min'.obs;

  final RxList<tags.Tag> availableTags = <tags.Tag>[].obs;
  final RxSet<int> selectedTagIds = <int>{}.obs;
  final RxBool isLoadingTags = false.obs;

  final RxInt selectedIndex = (-1).obs;
  final RxSet<int> editingIndices = <int>{}.obs;

  final Rxn<int> expandedIndex = Rxn<int>();

  final RxBool isPublishing = false.obs;

  final ScrollController scrollController = ScrollController();
  final RxInt currentStep = 0.obs;

  final List<String> readingTimes = ['3 min', '5 min', '10 min', '15 min'];

  final List<TextEditingController> sectionControllers =
      <TextEditingController>[];
  final List<TextEditingController> sectionContentControllers =
      <TextEditingController>[];

  @override
  void onInit() {
    super.onInit();
    _syncSectionControllers();
    expandedIndex.value = 0;

    titleController.addListener(_recomputeStep);
    subtitleController.addListener(_recomputeStep);
    loadTags();
  }

  @override
  void onClose() {
    titleController.removeListener(_recomputeStep);
    subtitleController.removeListener(_recomputeStep);
    titleController.dispose();
    subtitleController.dispose();
    scrollController.dispose();

    for (final controller in sectionControllers) {
      controller.dispose();
    }
    for (final controller in sectionContentControllers) {
      controller.removeListener(_recomputeStep);
      controller.dispose();
    }

    super.onClose();
  }

  void _recomputeStep() {
    final detailsFilled =
        titleController.text.trim().isNotEmpty &&
        subtitleController.text.trim().isNotEmpty;
    final contentFilled = sectionContentControllers.any(
      (c) => c.text.trim().isNotEmpty,
    );

    if (contentFilled) {
      currentStep.value = 2;
    } else if (detailsFilled) {
      currentStep.value = 1;
    } else {
      currentStep.value = 0;
    }
  }

  void cancel() {
    Get.back();
  }

  void selectReadingTime(String value) {
    selectedReadingTime.value = value;
  }

  void selectButton(int index) {
    selectedIndex.value = index;
  }



  Future<void> loadTags() async {
    isLoadingTags.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      final result = await _blogRepository.getTags(token: token);
      result.fold(
        (error) => AppSnackBar.error(error),
        (response) => availableTags.assignAll(response.data),
      );
    } finally {
      isLoadingTags.value = false;
    }
  }

  void toggleTag(int id) {
    if (selectedTagIds.contains(id)) {
      selectedTagIds.remove(id);
    } else {
      selectedTagIds.add(id);
    }
  }

  

  Future<void> pickCoverImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      selectedImages.assignAll([picked]);
    }
  }

  void removeCoverImage() {
    selectedImages.clear();
  }



  void toggleSection(int index) {
    expandedIndex.value = expandedIndex.value == index ? null : index;
  }

  void startEditSection(int index) {
    editingIndices.add(index);
    sectionControllers[index].text = sections[index];
    expandedIndex.value = index;
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
    if (index < 0 || index >= sections.length) return;

    editingIndices.remove(index);
    sections.removeAt(index);
    sectionControllers.removeAt(index).dispose();

    final removedContentController = sectionContentControllers.removeAt(index);
    removedContentController.removeListener(_recomputeStep);
    removedContentController.dispose();

    if (expandedIndex.value == index) {
      expandedIndex.value = null;
    } else if (expandedIndex.value != null && expandedIndex.value! > index) {
      expandedIndex.value = expandedIndex.value! - 1;
    }

    _recomputeStep();
  }

  void addSection() {
    final newSectionIndex = sections.length + 1;

    sections.add('New section $newSectionIndex');
    sectionControllers.add(
      TextEditingController(text: 'New section $newSectionIndex'),
    );

    final newContentController = TextEditingController();
    newContentController.addListener(_recomputeStep);
    sectionContentControllers.add(newContentController);

    final newIndex = sections.length - 1;
    editingIndices.add(newIndex);
    expandedIndex.value = newIndex;
  }


  Future<void> saveDraft() async {
    if (!_validateForm()) return;
    await _createBlog(isPublished: false);
  }

  Future<void> publishBlog() async {
    if (!_validateForm()) return;
    await _createBlog(isPublished: true);
  }

  Future<void> _createBlog({required bool isPublished}) async {
    if (isPublishing.value) return;

    try {
      isPublishing.value = true;

      final Map<String, String> fields = {};

      fields['title'] = titleController.text.trim();
      fields['subtitle'] = subtitleController.text.trim();
      fields['reading_time'] = selectedReadingTime.value.replaceAll(' min', '');
      fields['is_published'] = isPublished ? '1' : '0';

      int tagIndex = 0;
      for (final tagId in selectedTagIds) {
        fields['tags[$tagIndex]'] = tagId.toString();
        tagIndex++;
      }

      for (int i = 0; i < sections.length; i++) {
       
        final titleText = sectionControllers[i].text.trim();
        fields['sections[$i][title]'] = titleText.isNotEmpty
            ? titleText
            : sections[i];
        fields['sections[$i][content]'] = sectionContentControllers[i].text
            .trim();
        fields['sections[$i][order]'] = (i + 1).toString();
      }

      final Map<String, String> files = {};
      if (selectedImages.isNotEmpty) {
        files['cover_image'] = selectedImages.first.path;
      }

      final String? token = await _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        AppSnackBar.error('Token not found');
        return;
      }

      final result = await _blogRepository.CreateBlog(
        fields: fields,
        files: files,
        token: token,
      );

      result.fold((error) => AppSnackBar.error(error), (response) {
        AppSnackBar.success(
          isPublished
              ? 'Blog published successfully'
              : 'Draft saved successfully',
        );
        Get.back(result: isPublished);
      });
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isPublishing.value = false;
    }
  }

  void resetForm() {
    titleController.clear();
    subtitleController.clear();
    selectedImages.clear();
    selectedTagIds.clear();
    selectedReadingTime.value = readingTimes[2];
    selectedIndex.value = -1;
    expandedIndex.value = 0;

    for (final controller in sectionContentControllers) {
      controller.clear();
    }

    _recomputeStep();
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
    if (selectedTagIds.isEmpty) {
      AppSnackBar.error('Select at least one tag');
      return false;
    }
    for (int i = 0; i < sectionContentControllers.length; i++) {
      if (sectionContentControllers[i].text.trim().isEmpty) {
        AppSnackBar.error(
          'Content for "${sectionControllers[i].text.trim().isNotEmpty ? sectionControllers[i].text.trim() : sections[i]}" section is required',
        );
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
      controller.removeListener(_recomputeStep);
      controller.dispose();
    }

    sectionControllers.clear();
    sectionContentControllers.clear();

    for (final section in sections) {
      sectionControllers.add(TextEditingController(text: section));

      final contentController = TextEditingController();
      contentController.addListener(_recomputeStep);
      sectionContentControllers.add(contentController);
    }
  }
}
