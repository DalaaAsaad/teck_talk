import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/profile_response.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

enum SocialPlatform { facebook, instagram, x, reddit }

class EditProfileController extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();
  final ImagePicker _picker = ImagePicker();

  late final bool isOnboarding;

  final TextEditingController bioController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  final Map<SocialPlatform, TextEditingController> socialControllers = {
    SocialPlatform.facebook: TextEditingController(),
    SocialPlatform.instagram: TextEditingController(),
    SocialPlatform.x: TextEditingController(),
    SocialPlatform.reddit: TextEditingController(),
  };

  final Rxn<XFile> newAvatar = Rxn<XFile>();
  final Rxn<XFile> newCoverImage = Rxn<XFile>();
  final RxnString existingAvatarUrl = RxnString();
  final RxnString existingCoverUrl = RxnString();
  final RxBool removeAvatar = false.obs;
  final RxBool removeCoverImage = false.obs;

  final RxList<Tag> availableTags = <Tag>[].obs;
  final RxSet<int> selectedTagIds = <int>{}.obs;
  final RxBool isLoadingTags = false.obs;

  final RxBool isSaving = false.obs;
  final RxBool isSaved = false.obs;

  String initialName = '';
  String initialEmail = '';
  String initialUsername = '';

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    isOnboarding = args is Map && args['isOnboarding'] == true;

    final profile = args is Map ? args['profile'] as ProfileData? : null;

    if (profile != null) {
      bioController.text = profile.bio ?? '';
      websiteController.text = profile.website ?? '';
      locationController.text = profile.location ?? '';
      final cachedAvatarUrl = _sharedPrefs.getUserAvatarUrl();
      existingAvatarUrl.value = profile.avatarUrl.isEmpty
          ? cachedAvatarUrl
          : profile.avatarUrl;
      existingCoverUrl.value = profile.coverImageUrl;

      initialName = profile.name;
      initialEmail = profile.email;
      initialUsername = profile.username;

      _prefillSocialLinks(profile.socialLinks);
      _prefillTagIds(profile.tags);
    }

    loadTags();
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

  void _prefillTagIds(List<dynamic> rawTags) {
    for (final raw in rawTags) {
      int? id;
      if (raw is Map) {
        id = int.tryParse(raw['id']?.toString() ?? '');
      } else {
        id = int.tryParse(raw?.toString() ?? '');
      }
      if (id != null) selectedTagIds.add(id);
    }
  }

  void _prefillSocialLinks(List<dynamic> rawLinks) {
    for (final raw in rawLinks) {
      final url = raw?.toString().trim() ?? '';
      if (url.isEmpty) continue;

      final lower = url.toLowerCase();
      SocialPlatform? platform;
      if (lower.contains('facebook.com') || lower.contains('fb.com')) {
        platform = SocialPlatform.facebook;
      } else if (lower.contains('instagram.com')) {
        platform = SocialPlatform.instagram;
      } else if (lower.contains('twitter.com') || lower.contains('x.com')) {
        platform = SocialPlatform.x;
      } else if (lower.contains('reddit.com')) {
        platform = SocialPlatform.reddit;
      }

      if (platform != null) {
        socialControllers[platform]!.text = url;
      }
    }
  }

  @override
  void onClose() {
    bioController.dispose();
    websiteController.dispose();
    locationController.dispose();
    for (final c in socialControllers.values) {
      c.dispose();
    }
    super.onClose();
  }

  String normalizeUrl(String value) {
    value = value.trim();

    if (value.isEmpty) return '';

    if (!value.startsWith('http://') && !value.startsWith('https://')) {
      return 'https://$value';
    }

    return value;
  }

  Future<XFile> _normalizeImageExtension(XFile file) async {
    final path = file.path;
    final ext = path.split('.').last.toLowerCase();
    if (ext == 'jpg') {
      final newPath = path.replaceAll(
        RegExp(r'\.jpg$', caseSensitive: false),
        '.jpeg',
      );
      final newFile = await File(path).copy(newPath);
      return XFile(newFile.path);
    }
    return file;
  }

  bool get hasAvatar =>
      newAvatar.value != null ||
      (existingAvatarUrl.value != null && !removeAvatar.value);

  bool get hasCoverImage =>
      newCoverImage.value != null ||
      (existingCoverUrl.value != null && !removeCoverImage.value);

  Future<void> pickAvatar() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (picked != null) {
        final normalized = await _normalizeImageExtension(picked);
        newAvatar.value = normalized;
        removeAvatar.value = false;
      }
    } catch (e) {
      AppSnackBar.error('Could not open gallery: $e');
    }
  }

  Future<void> pickCoverImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked != null) {
        newCoverImage.value = await _normalizeImageExtension(picked);
        removeCoverImage.value = false;
      }
    } catch (e) {
      AppSnackBar.error('Could not open gallery: $e');
    }
  }

  void removeAvatarImage() {
    newAvatar.value = null;
    removeAvatar.value = true;
  }

  void removeCoverImagePic() {
    newCoverImage.value = null;
    removeCoverImage.value = true;
  }

  Future<void> saveProfile() async {
    isSaving.value = true;

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final fields = <String, String>{};

      final bio = bioController.text.trim();
      if (bio.isNotEmpty) {
        fields['bio'] = bio;
      }

      final website = websiteController.text.trim();

      if (website.isNotEmpty) {
        fields['website'] = normalizeUrl(website);
      }

      int linkIndex = 0;

      for (final platform in SocialPlatform.values) {
        final value = socialControllers[platform]!.text.trim();

        if (value.isNotEmpty) {
          fields['social_links[$linkIndex]'] = value;
          linkIndex++;
        }
      }

      int tagIndex = 0;

      for (final tagId in selectedTagIds) {
        fields['tags[$tagIndex]'] = tagId.toString();
        tagIndex++;
      }

      final files = <String, String>{};

      if (newAvatar.value != null) {
        files['avatar'] = newAvatar.value!.path;
      } else if (removeAvatar.value) {
        fields['avatar'] = '';
      }

      if (newCoverImage.value != null) {
        files['cover_image'] = newCoverImage.value!.path;
      } else if (removeCoverImage.value) {
        fields['cover_image'] = '';
      }

      final result = await _authRepository.editInfoProfile(
        fields: fields,
        files: files,
        token: token,
      );

      result.fold(
        (error) {
        
          if (isOnboarding && error.trim() == 'No changes detected') {
            _onSaveSuccess();
          } else {
            AppSnackBar.error(error);
          }
        },
        (response) {
          _sharedPrefs.saveUserImages(
            avatarUrl: response.data.avatarUrl,
            coverImageUrl: response.data.coverImageUrl,
          );
          _onSaveSuccess();
        },
      );
    } catch (e) {
      AppSnackBar.error('Something went wrong');
    } finally {
      isSaving.value = false;
    }
  }

  void _onSaveSuccess() async {
    isSaved.value = true;

    await Future.delayed(const Duration(milliseconds: 700));
    isSaved.value = false;

    AppSnackBar.success('Profile updated successfully');

    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().loadProfile();
    }

    if (isOnboarding) {
      Get.offAllNamed(AppRoutes.mainView);
    }
  }
}
