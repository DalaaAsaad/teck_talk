import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/posts_response.dart';
import 'package:tech_talk/core/data/responses/profile_response.dart';
import 'package:tech_talk/core/data/responses/saved_item_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class ProfileController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  final RxBool isLoading = false.obs;
  final Rxn<ProfileData> profileData = Rxn<ProfileData>();
  final Rxn<SavedItemsResponse> savedItems = Rxn<SavedItemsResponse>();
  final Rxn<PostsResponse> myPostsAndDrafts = Rxn<PostsResponse>();

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
        (response) => profileData.value = response.data,
      );

      savedResult.fold(
        (failure) => AppSnackBar.error(failure),
        (response) => savedItems.value = response,
      );

      myPostsResult.fold(
        (failure) => AppSnackBar.error(failure),
        (response) => myPostsAndDrafts.value = response,
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }
}
