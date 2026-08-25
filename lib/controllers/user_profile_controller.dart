import 'package:get/get.dart';
import 'package:tech_talk/controllers/post_action_controller.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/blog_info_response.dart';
import 'package:tech_talk/core/data/responses/public_user_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class UserProfileController extends GetxController {
  UserProfileController();
  late final String userName;
  final AuthRepository _authRepository = AuthRepository();
  final Rxn<publicUserResponse> profileData = Rxn<publicUserResponse>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  // Follow/Unfollow
  final RxBool isFollowLoading = false.obs;
  final RxBool isFollowing = false.obs;
  final RxInt followersCount = 0.obs;

  // Block/Unblock
  final RxBool isBlockLoading = false.obs;
  final RxBool isBlocked = false.obs;

  // Posts tab
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxBool isPostsLoading = false.obs;
  final PostActionController postActionController =
      Get.find<PostActionController>();

  // Blogs tab
  final RxList<BlogInfoData> blogs = <BlogInfoData>[].obs;
  final RxBool isBlogsLoading = false.obs;
  final RxBool isBlogsLoadingMore = false.obs;
  int _blogsCurrentPage = 1;
  bool _blogsHasMorePages = true;
  int get currentUserId => _sharedPrefs.getUserId() ?? 0;

  @override
  void onInit() {
    super.onInit();
    userName = Get.arguments as String;
    fetchUserProfile();
    loadUserPosts();
    loadUserBlogs();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        errorMessage.value = 'Authentication required';
        return;
      }

      final result = await _authRepository.getUserProfile(
        token: token,
        userName: userName,
      );

      result.fold(
        (error) {
          errorMessage.value = error;
        },
        (response) {
          profileData.value = response;
          isFollowing.value = response.data.isFollowing;
          followersCount.value = response.data.followersCount;
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUserPosts() async {
    isPostsLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      final result = await _authRepository.getMyPosts(
        token: token,
        userName: userName,
      );

      result.fold(
        (error) => AppSnackBar.error(error),
        (response) => posts.assignAll(response.data),
      );
    } finally {
      isPostsLoading.value = false;
    }
  }

  Future<void> loadUserBlogs() async {
    isBlogsLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      _blogsCurrentPage = 1;
      final result = await _authRepository.getUserBlogs(
        token: token,
        userName: userName,
        page: _blogsCurrentPage,
      );

      result.fold(
        (error) => AppSnackBar.error(error),
        (response) {
          blogs.assignAll(response.data);
          _blogsHasMorePages = response.pagination?.hasMorePages ?? false;
        },
      );
    } finally {
      isBlogsLoading.value = false;
    }
  }

  Future<void> loadMoreUserBlogs() async {
    if (isBlogsLoadingMore.value || !_blogsHasMorePages) return;

    isBlogsLoadingMore.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) return;

      final nextPage = _blogsCurrentPage + 1;
      final result = await _authRepository.getUserBlogs(
        token: token,
        userName: userName,
        page: nextPage,
      );

      result.fold(
        (error) => AppSnackBar.error(error),
        (response) {
          blogs.addAll(response.data);
          _blogsCurrentPage = nextPage;
          _blogsHasMorePages = response.pagination?.hasMorePages ?? false;
        },
      );
    } finally {
      isBlogsLoadingMore.value = false;
    }
  }

  Future<void> toggleFavorite(PostModel post) async {
    await postActionController.likePost(post);
    await loadUserPosts();
  }

  void toggleComment(PostModel post) {
    Get.toNamed('/comments', arguments: post);
  }

  Future<void> toggleSaved(PostModel post) async {
    if (!post.isSaved) {
      await postActionController.savedRequest(post);
    } else {
      await postActionController.removeSaved(post);
    }
    await loadUserPosts();
  }

  Future<void> toggleFollow() async {
    if (isFollowLoading.value) return;

    final wasFollowing = isFollowing.value;
    final previousCount = followersCount.value;

    isFollowLoading.value = true;
    isFollowing.value = !wasFollowing;
    followersCount.value = wasFollowing
        ? previousCount - 1
        : previousCount + 1;

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        _revertFollowState(wasFollowing, previousCount);
        return;
      }

      final result = wasFollowing
          ? await _authRepository.unfollowUser(username: userName, token: token)
          : await _authRepository.followUser(username: userName, token: token);

      result.fold(
        (error) {
          AppSnackBar.error(error);
          _revertFollowState(wasFollowing, previousCount);
        },
        (response) {
          isFollowing.value = response.data.isFollowing;
          followersCount.value = response.data.followersCount;
        },
      );
    } catch (e) {
      AppSnackBar.error('Something went wrong');
      _revertFollowState(wasFollowing, previousCount);
    } finally {
      isFollowLoading.value = false;
    }
  }

  void _revertFollowState(bool wasFollowing, int previousCount) {
    isFollowing.value = wasFollowing;
    followersCount.value = previousCount;
  }

  Future<void> toggleBlock() async {
    if (isBlockLoading.value) return;

    final wasBlocked = isBlocked.value;

    isBlockLoading.value = true;
    isBlocked.value = !wasBlocked;

    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        isBlocked.value = wasBlocked;
        return;
      }

      final result = wasBlocked
          ? await _authRepository.unblockUser(username: userName, token: token)
          : await _authRepository.blockUser(username: userName, token: token);

      result.fold(
        (error) {
          AppSnackBar.error(error);
          isBlocked.value = wasBlocked;
        },
        (_) {
          AppSnackBar.success(
            isBlocked.value ? 'User blocked' : 'User unblocked',
          );
        },
      );
    } catch (e) {
      AppSnackBar.error('Something went wrong');
      isBlocked.value = wasBlocked;
    } finally {
      isBlockLoading.value = false;
    }
  }
}