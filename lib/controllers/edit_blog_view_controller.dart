import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/blog_info_response.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart' as tags;
import 'package:tech_talk/ui/shared/shared_widget/app_image_picker.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class EditBlogViewController extends GetxController {
  final Rxn<BlogInfoData> blogInfo = Rxn<BlogInfoData>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final RxString readingTime = ''.obs;

  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _blogRepository = AuthRepository();

  final RxList<tags.Tag> availableTags = <tags.Tag>[].obs;
  final RxSet<int> selectedTagIds = <int>{}.obs;
  final RxBool isLoadingTags = false.obs;

  final RxBool isPublished = false.obs;
  final Rxn<XFile> newCoverImage = Rxn<XFile>();
  final RxBool removeCoverImage = false.obs;
  final RxBool isSaving = false.obs;

  final ScrollController scrollController = ScrollController();
  final RxInt currentStep = 0.obs;



  final RxList<Section> sections = <Section>[].obs;
  final List<TextEditingController> sectionTitleControllers = [];
  final List<TextEditingController> sectionContentControllers = [];
  final Rxn<int> expandedSectionIndex = Rxn<int>();

  final Map<int, Section> _originalSectionsById = {};

  final List<int> _pendingDeletedSectionIds = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      blogInfo.value = Get.arguments as BlogInfoData;
      _prefillFields();
    }

    titleController.addListener(_recomputeStep);
    subtitleController.addListener(_recomputeStep);
    ever(isPublished, (_) => _recomputeStep());
    ever(readingTime, (_) => _recomputeStep());

    _recomputeStep();
    loadTags();
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

  @override
  void onClose() {
    titleController.removeListener(_recomputeStep);
    subtitleController.removeListener(_recomputeStep);

    titleController.dispose();
    subtitleController.dispose();

    for (final c in sectionTitleControllers) {
      c.dispose();
    }
    for (final c in sectionContentControllers) {
      c.dispose();
    }

    scrollController.dispose();

    super.onClose();
  }


  void _recomputeStep() {
    final detailsFilled =
        titleController.text.trim().isNotEmpty &&
        subtitleController.text.trim().isNotEmpty;

    if (isPublished.value) {
      currentStep.value = 2;
    } else if (detailsFilled || hasCoverImage) {
      currentStep.value = 1;
    } else {
      currentStep.value = 0;
    }
  }

  void _prefillFields() {
    final blog = blogInfo.value;
    if (blog == null) return;
    titleController.text = blog.title;
    subtitleController.text = blog.subtitle;
    readingTime.value = blog.readingTime ?? '';
    selectedTagIds.assignAll(blog.tags.map((tag) => tag.id));
    isPublished.value = blog.isPublished;

    sections.assignAll(blog.sections);

    _originalSectionsById.clear();
    for (final s in blog.sections) {
      _originalSectionsById[s.id] = s;
    }
    _pendingDeletedSectionIds.clear();

    _syncSectionControllers();
  }

  void _syncSectionControllers() {
    for (final c in sectionTitleControllers) {
      c.dispose();
    }
    for (final c in sectionContentControllers) {
      c.dispose();
    }

    sectionTitleControllers.clear();
    sectionContentControllers.clear();

    for (final section in sections) {
      sectionTitleControllers.add(TextEditingController(text: section.title));
      sectionContentControllers.add(
        TextEditingController(text: section.content),
      );
    }
  }

  bool get hasCoverImage =>
      newCoverImage.value != null ||
      (blogInfo.value?.coverImageUrl != null && !removeCoverImage.value);

  Future<void> pickCoverImage() async {
    final picked = await AppImagePicker.instance.pickImage(imageQuality: 85);
    if (picked != null) {
      newCoverImage.value = picked;
      removeCoverImage.value = false;
      _recomputeStep();
    }
  }

  void removeExistingCoverImage() {
    newCoverImage.value = null;
    removeCoverImage.value = true;
    _recomputeStep();
  }

  bool get hasUnsavedChanges {
    final blog = blogInfo.value;
    if (blog == null) return false;
    return titleController.text.trim() != blog.title ||
        subtitleController.text.trim() != blog.subtitle ||
        readingTime.value.trim() != (blog.readingTime ?? '') ||
        !setEquals(selectedTagIds, blog.tags.map((t) => t.id).toSet()) ||
        isPublished.value != blog.isPublished ||
        newCoverImage.value != null ||
        removeCoverImage.value ||
        _hasUnsavedSectionChanges;
  }

  bool get _hasUnsavedSectionChanges {
    if (_pendingDeletedSectionIds.isNotEmpty) return true;
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final title = sectionTitleControllers[i].text.trim();
      final content = sectionContentControllers[i].text.trim();
      if (section.id == 0) return true; // سيكشن جديدة لسا ما اتحفظت
      final original = _originalSectionsById[section.id];
      if (original == null ||
          original.title != title ||
          original.content != content ||
          original.order != (i + 1).toString()) {
        return true;
      }
    }
    return false;
  }



  void toggleSection(int index) {
    expandedSectionIndex.value = expandedSectionIndex.value == index
        ? null
        : index;
  }

  void addSection() {
    final newOrder = sections.length + 1;
    sections.add(
      Section(id: 0, title: '', content: '', order: newOrder.toString()),
    );
    sectionTitleControllers.add(TextEditingController());
    sectionContentControllers.add(TextEditingController());
    expandedSectionIndex.value = sections.length - 1;
  }

  void deleteSection(int index) {
    final section = sections[index];
    if (section.id != 0) {
      _pendingDeletedSectionIds.add(section.id);
    }

    sections.removeAt(index);
    sectionTitleControllers.removeAt(index).dispose();
    sectionContentControllers.removeAt(index).dispose();

    if (expandedSectionIndex.value == index) {
      expandedSectionIndex.value = null;
    } else if (expandedSectionIndex.value != null &&
        expandedSectionIndex.value! > index) {
      expandedSectionIndex.value = expandedSectionIndex.value! - 1;
    }
  }



  Future<void> saveChanges() async {
    final blog = blogInfo.value;

    if (blog == null) {
      AppSnackBar.error('Blog data not found');
      return;
    }

    if (titleController.text.trim().isEmpty) {
      AppSnackBar.error('Title is required');
      return;
    }

    if (readingTime.value.trim().isEmpty) {
      AppSnackBar.error('Reading time is required');
      return;
    }

    for (int i = 0; i < sections.length; i++) {
      if (sectionTitleControllers[i].text.trim().isEmpty) {
        AppSnackBar.error('Section ${i + 1} title cannot be empty');
        return;
      }
    }

    isSaving.value = true;

    try {
      final token = await _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final fields = <String, String>{
        'title': titleController.text.trim(),
        'subtitle': subtitleController.text.trim(),
        'reading_time': readingTime.value.trim(),
        'is_published': isPublished.value ? '1' : '0',
        'remove_cover_image': removeCoverImage.value ? '1' : '0',
      };

      for (int i = 0; i < selectedTagIds.length; i++) {
        fields['tags[$i]'] = selectedTagIds.elementAt(i).toString();
      }

      final files = <String, String>{};

      if (newCoverImage.value != null) {
        files['cover_image'] = newCoverImage.value!.path;
      }

      final headerResult = await _blogRepository.editHeaderBlog(
        fields: fields,
        files: files,
        token: token,
        blogId: blog.id,
      );

      final headerSucceeded = await headerResult.fold(
        (error) {
          AppSnackBar.error(error);
          return false;
        },
        (response) => true,
      );

      if (!headerSucceeded) return;

      int sectionErrors = 0;

      for (final sectionId in _pendingDeletedSectionIds) {
        final result = await _blogRepository.deleteSectionBlog(
          idSection: sectionId,
          idBlog: blog.id,
          token: token,
        );
        result.fold((error) {
          sectionErrors++;
          AppSnackBar.error(error);
        }, (_) {});
      }

      for (int i = 0; i < sections.length; i++) {
        final section = sections[i];
        final title = sectionTitleControllers[i].text.trim();
        final content = sectionContentControllers[i].text.trim();
        final order = (i + 1).toString();

        final sectionFields = <String, String>{
          'title': title,
          'content': content,
          'order': order,
        };

        if (section.id == 0) {
          // سيكشن جديدة - لازم تتنشئ.
          final result = await _blogRepository.createSection(
            idBlog: blog.id,
            fields: sectionFields,
            files: const {},
            token: token,
          );
          result.fold((error) {
            sectionErrors++;
            AppSnackBar.error(error);
          }, (created) => sections[i] = created);
        } else {
          final original = _originalSectionsById[section.id];
          final changed =
              original == null ||
              original.title != title ||
              original.content != content ||
              original.order != order;

          if (!changed) continue; 

          final result = await _blogRepository.updateSection(
            idSection: section.id,
            idBlog: blog.id,
            fields: sectionFields,
            files: const {},
            token: token,
          );
          result.fold((error) {
            sectionErrors++;
            AppSnackBar.error(error);
          }, (updated) => sections[i] = updated);
        }
      }

      Get.back(result: true);
      Future.delayed(const Duration(milliseconds: 300), () {
        AppSnackBar.success(
          sectionErrors == 0
              ? 'Blog updated successfully'
              : 'Blog updated, but some sections failed to save',
        );
      });
    } catch (e) {
      AppSnackBar.error('Something went wrong');
    } finally {
      isSaving.value = false;
    }
  }
}