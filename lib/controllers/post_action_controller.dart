import 'package:get/get.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';

class PostActionController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  Future<void> savedRequest(PostModel post) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.savePostOrBlog(
        id: post.id,
        type: "post",
        token: token!,
      );

      result.fold(
        (failure) {
          // AppSnackBar.error(failure);
        },
        (response) {
          post.isSaved = true;
        },
      );
    } catch (e) {
      print(e);
      // AppSnackBar.error(e.toString());
    }
  }

  Future<void> removeSaved(PostModel post) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.deleteSaved(
        id: post.id,
        type: "post",
        token: token!,
      );

      result.fold(
        (failure) {
          // AppSnackBar.error(failure);
        },
        (response) {
          post.isSaved = false;
          // posts.refresh();
        },
      );
    } catch (e) {
      print(e);
      // AppSnackBar.error(e.toString());
    }
  }

  Future<void> likePost(PostModel post) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.likePost(id: post.id, token: token!);
      result.fold(
        (failure) {
          // AppSnackBar.error(failure);
        },
        (response) {
          post.isLikedByUser = !post.isLikedByUser;

          if (post.isLikedByUser) {
            post.likesCount += 1;
          } else {
            post.likesCount -= 1;
          }
          // posts.refresh();
        },
      );
    } catch (e) {
      // print(e);
      // AppSnackBar.error(e.toString());
    }
  }

  Future<void> DeletePost(PostModel post) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.DeletePost(
        id: post.id,
        token: token!,
      );
      result.fold((failure) {
        // AppSnackBar.error(failure);
      }, (response) {});
    } catch (e) {
      print(e);
      // AppSnackBar.error(e.toString());
    }
  }
}
