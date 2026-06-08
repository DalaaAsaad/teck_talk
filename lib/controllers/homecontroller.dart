import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/ui/views/comments/comments.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:tech_talk/ui/views/main_view/blog/blog.dart';

class Homecontroller extends GetxController {
  RxBool isFavorit = false.obs;
  RxBool isComment = false.obs;
  final AuthRepository _authRepository = AuthRepository();
  final RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final RxList<PostSavedModel> posts = <PostSavedModel>[].obs;
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  //* GET POSTS METHOD */
  Future<void> getPosts({int page = 1}) async {
    isLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.getPosts(page: page, token: token!);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (postsResponse) {
          print(postsResponse.data);
          posts.assignAll(postsResponse.data);
          currentPage.value = postsResponse.pagination.currentPage;
          lastPage.value = postsResponse.pagination.lastPage;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> nextPage() async {
    int next = currentPage.value + 1;
    if (currentPage.value == 2 && lastPage.value == 2) {
      next = 3;
    }
    try {
      await getPosts(page: next);
    } finally {}
  }

  Future<void> previousPage() async {
    if (currentPage.value <= 1) return;

    try {
      await getPosts(page: currentPage.value - 1);
    } finally {}
  }

  //* TOGGLE METHODS */
  void toggleFavorite(PostSavedModel post) {
    likePost(post);
  }

  void toggleComment(PostSavedModel post) {
    Get.toNamed(
      AppRoutes.comments,
      arguments: [
        post.id,
        post.commentsCount,
        post.likesCount,
        post.isLikedByUser,
      ],
    );
  }

  //* saved method */
  void toggleSaved(PostSavedModel post) {
    if (!post.isSaved) {
      savedRequest(post);
    } else {
      removeSaved(post);
    }
  }

  void savedRequest(PostSavedModel post) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.savePostOrBlog(
        id: post.id,
        type: "post",
        token: token!,
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          post.isSaved = true;
          posts.refresh();
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error(e.toString());
    }
  }

  void removeSaved(PostSavedModel post) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.deleteSaved(
        id: post.id,
        type: "post",
        token: token!,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          post.isSaved = false;
          posts.refresh();
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error(e.toString());
    }
  }

  //* like request */

  void likePost(PostSavedModel post) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.likePost(id: post.id, token: token!);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          post.isLikedByUser = !post.isLikedByUser;
          if (post.isLikedByUser) {
            post.likesCount += 1;
          } else {
            post.likesCount -= 1;
          }
          posts.refresh();
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }
}
