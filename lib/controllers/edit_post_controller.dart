import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart';
import 'package:tech_talk/core/data/responses/update_post_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_image_picker.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class EditPostController extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();

  late final PostModel _post;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final RxString selectedLanguage = ''.obs;
  final RxBool isPublished = false.obs;

  // Tags
  final RxBool isLoadingTags = false.obs;
  final RxList<Tag> availableTags = <Tag>[].obs;
  final RxSet<int> selectedTagIds = <int>{}.obs;

  // Photos
  final RxList<PostPhoto> photos = <PostPhoto>[].obs;
  final RxBool isUploadingPhoto = false.obs;
  final RxSet<String> deletingPhotoIds = <String>{}.obs;

  // Save
  final RxBool isSaving = false.obs;
  final RxBool isSaved = false.obs;

  @override
  void onInit() {
    super.onInit();

    _post = Get.arguments as PostModel;

    titleController.text = _post.title;
    contentController.text = _post.body;
    codeController.text = _post.code ?? '';
    selectedLanguage.value = _post.codeLanguage ?? '';
    isPublished.value = _post.isPublished;

    photos.assignAll(
      _post.photos.map(
        (photo) =>
            PostPhoto(id: photo.id, url: photo.url, sortOrder: photo.sortOrder),
      ),
    );

    selectedTagIds.assignAll(_post.tags.map((t) => t.id));

    loadTags();
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    codeController.dispose();
    super.onClose();
  }


  Future<void> loadTags() async {
    isLoadingTags.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      final result = await _authRepository.getTags(token: token);
      result.fold(
        (error) => AppSnackBar.error(error),
        (response) => availableTags.assignAll(response.data),
      );
    } finally {
      isLoadingTags.value = false;
    }
  }


  Future<void> pickAndUploadPhotos() async {
    try {
      final List<XFile> picked = await AppImagePicker.instance.pickMultiImage(
        imageQuality: 80,
      );
      if (picked.isEmpty) return;

      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      isUploadingPhoto.value = true;

      int successCount = 0;

      for (final image in picked) {
        final result = await _authRepository.addPostPhoto(
          idPost: _post.id,
          photoPath: image.path,
          token: token,
        );

        result.fold((error) => AppSnackBar.error(error), (updatedPost) {
          successCount++;
          
          photos.assignAll(updatedPost.data.photos);
        });
      }

      if (successCount > 0) {
        AppSnackBar.success(
          successCount == picked.length
              ? 'Photos added successfully'
              : 'Added $successCount of ${picked.length} photos',
        );
      }
    } catch (e) {
      AppSnackBar.error('Could not upload photos: $e');
    } finally {
      isUploadingPhoto.value = false;
    }
  }


  Future<void> removePhoto(PostPhoto photo) async {
    final photoIdStr = photo.id.toString();
    deletingPhotoIds.add(photoIdStr);
    try {
      final token = await _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      print('🗑️ PHOTO TO DELETE');
      print('id = ${photo.id}');
      print('type = ${photo.id.runtimeType}');

      for (final p in photos) {
        print(
          '📸 LIST PHOTO => id=${p.id}, type=${p.id.runtimeType}, url=${p.url}',
        );
      }
      final result = await _authRepository.deletePostPhoto(
        idPost: _post.id,
        photo: photoIdStr,
        token: token,
      );

      result.fold(
        (error) {
          print('❌ DELETE FAILED: $error');
          AppSnackBar.error(error);
        },
        (response) {
          print('✅ DELETE SUCCESS');

          print(
            '📸 BEFORE: ${photos.map((p) => '${p.id}:${p.id.runtimeType}').toList()}',
          );

          photos.removeWhere((p) => p.id.toString() == photoIdStr);

          print('📸 AFTER: ${photos.map((p) => p.id).toList()}');

          AppSnackBar.success('Photo removed');
        },
      );
    } catch (e, stackTrace) {
      print('❌ DELETE EXCEPTION: $e');
      print(stackTrace);

      AppSnackBar.error('Could not remove photo: $e');
    } finally {
      deletingPhotoIds.remove(photoIdStr);
    }
  }


  Future<void> saveChanges() async {
    if (titleController.text.trim().isEmpty) {
      AppSnackBar.error('Title is required');
      return;
    }
    if (contentController.text.trim().isEmpty) {
      AppSnackBar.error('Content is required');
      return;
    }

    isSaving.value = true;

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final body = <String, dynamic>{
        'title': titleController.text.trim(),
        'body': contentController.text.trim(),
        'code': codeController.text.trim(),
        'code_language': selectedLanguage.value,
        'is_published': isPublished.value,
        'tags': selectedTagIds.toList(),
      };

      final result = await _authRepository.updatePostContent(
        idPost: _post.id,
        body: body,
        token: token,
      );

      result.fold(
        (error) => AppSnackBar.error(error),
        (response) => _onSaveSuccess(),
      );
    } catch (e) {
      AppSnackBar.error('Something went wrong: $e');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> _onSaveSuccess() async {
    isSaved.value = true;
    await Future.delayed(const Duration(milliseconds: 900));
    isSaved.value = false;
    AppSnackBar.success('Post updated successfully');
  }
}