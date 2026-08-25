import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/post_action_controller.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/profile_response.dart';
import 'package:tech_talk/core/data/responses/saved_item_response.dart';
import 'package:tech_talk/core/services/pusher_service.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

enum ProfileMenuAction { activity, settings, logout }

class ProfileController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final RxBool isSigningOut = false.obs;
  final RxBool isLoading = false.obs;
  final Rxn<ProfileData> profileData = Rxn<ProfileData>();
  final Rxn<SavedItemsResponse> savedItems = Rxn<SavedItemsResponse>();
  final RxList<PostModel> posts = <PostModel>[].obs;
  final int currentUserId = SharedPreferenceRepository().getUserId() ?? 0;
  final PostActionController postActionController =
      Get.find<PostActionController>();

  final RxBool showMoreInfo = false.obs;
  void toggleMoreInfo() {
    showMoreInfo.value = !showMoreInfo.value;
  }

  void onMenuSelected(ProfileMenuAction action) {
    switch (action) {
      case ProfileMenuAction.activity:
        Get.toNamed(AppRoutes.myActivity);
        break;

      case ProfileMenuAction.settings:
        Get.toNamed(AppRoutes.settings);
        break;

      case ProfileMenuAction.logout:
        signOut();
        break;
    }
  }

  Future<void> loadProfile() async {
    if (isLoading.value) {
      return;
    }

    isLoading.value = true;
    try {
      final token = _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final userName = _sharedPrefs.getUserUserName();
      if (userName == null || userName.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final profileFuture = _authRepository.getInfoProfile(token: token);
      final savedFuture = _authRepository.getListsaved(token: token);
      final myPostsFuture = _authRepository.getMyPosts(
        token: token,
        userName: userName,
      );

      final results = await Future.wait([
        profileFuture,
        savedFuture,
        myPostsFuture,
      ]);

      final profileResult = results[0] as dynamic;
      final savedResult = results[1] as dynamic;
      final myPostsResult = results[2] as dynamic;

      profileResult.fold(
        (failure) => AppSnackBar.error(failure),
        (response) => {
          profileData.value = response.data,
          _sharedPrefs.saveBadge(response.data.badge),
          _sharedPrefs.saveUserImages(
            avatarUrl: response.data.avatarUrl,
            coverImageUrl: response.data.coverImageUrl,
          ),
        },
      );

      savedResult.fold(
        (failure) => AppSnackBar.error(failure),
        (response) => savedItems.value = response,
      );

      myPostsResult.fold(
        (failure) => () {
          AppSnackBar.error(failure);
        },
        (response) => posts.assignAll(response.data),
      );
    } catch (e) {
      print(e);
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    if (isSigningOut.value) return;

    isSigningOut.value = true;

    try {
      final token = _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        Get.offAllNamed(AppRoutes.signin);
        return;
      }

      final result = await _authRepository.signOut(token: token);

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) async {
          await _sharedPrefs.clearUserData();
          profileData.value = null;
          savedItems.value = null;
          // posts.value = null;

          AppSnackBar.success('Logged out successfully');
          await PusherService.instance.disconnect();
          Get.offAllNamed(AppRoutes.signin);
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isSigningOut.value = false;
    }
  }

  Future<void> refreshPostProfile() async {
    try {
      final token = _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        return;
      }

      final userName = _sharedPrefs.getUserUserName();

      if (userName == null || userName.isEmpty) {
        return;
      }

      final result = await _authRepository.getMyPosts(
        token: token,
        userName: userName,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          posts.assignAll(response.data);
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> toggleFavorite(PostModel post) async {
    await postActionController.likePost(post);
    await refreshPostProfile();
  }

  void toggleComment(PostModel post) {
    Get.toNamed(AppRoutes.comments, arguments: post);
  }

  Future<void> toggleSaved(PostModel post) async {
    if (!post.isSaved) {
      await postActionController.savedRequest(post);
    } else {
      await postActionController.removeSaved(post);
    }

    await refreshPostProfile();
  }

  Future<void> toggleDelete(PostModel post) async {
    await postActionController.DeletePost(post);
    await refreshPostProfile();
  }

  @override
  void onInit() {
    super.onInit();
    // loadProfile();
  }
}
