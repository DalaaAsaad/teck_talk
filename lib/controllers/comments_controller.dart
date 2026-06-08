import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class CommentsController extends RxController {
  RxBool isFavorite = false.obs;
  RxBool isLike = false.obs;
  RxBool isDislike = false.obs;
  final RxBool isLoading = false.obs;
  final TextEditingController typeController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final RxList<CommentModel> comments = <CommentModel>[].obs;
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();

  int get postId => (Get.arguments as List)[0];

  Future<void> getComments() async {
    isLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.getPostComments(
        id: postId,
        token: token!,
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (commentsResponse) {
          comments.assignAll(commentsResponse.data);
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void likeComment(CommentModel comment) async {
    try {
      final token = await _sharedPrefs.getAuthToken();

      final result = await _authRepository.likeComment(
        id: comment.id,
        token: token!,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          // toggle state
          if (comment.isLikedByUser) {
            comment.isLikedByUser = false;
            comment.likesCount = (int.parse(comment.likesCount) - 1).toString();
          } else {
            comment.isLikedByUser = true;
            comment.likesCount = (int.parse(comment.likesCount) + 1).toString();
          }

          comments.refresh();
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  void dislikeComment(CommentModel comment) async {
    try {
      final token = await _sharedPrefs.getAuthToken();

      final result = await _authRepository.dislikeComment(
        id: comment.id,
        token: token!,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          if (comment.isDislikedByUser) {
            comment.isDislikedByUser = false;
            comment.dislikesCount = (int.parse(comment.dislikesCount) - 1)
                .toString();
          } else {
            comment.isDislikedByUser = true;
            comment.dislikesCount = (int.parse(comment.dislikesCount) + 1)
                .toString();
          }

          comments.refresh();
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  void commentPost() async {
    if (typeController.text.isEmpty && codeController.text.isEmpty) {
      return;
    }
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.createCommentPost(
        token: token!,
        body: typeController.text,
        postId: postId,
        code: codeController.text,
        codeLanguage: '',
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          AppSnackBar.success(response.message);
          getComments();
          resetForm();
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  void resetForm() {
    typeController.clear();
    codeController.clear();
  }

  void toggleLike(CommentModel comment) {
    if (comment.isDislikedByUser) {
      comment.isDislikedByUser = false;
      comment.dislikesCount = (int.parse(comment.dislikesCount) - 1).toString();
    }

    likeComment(comment);
  }

  void toggleDislike(CommentModel comment) {
    if (comment.isLikedByUser) {
      comment.isLikedByUser = false;
      comment.likesCount = (int.parse(comment.likesCount) - 1).toString();
    }

    dislikeComment(comment);
  }

  String formatEngagement(int? value) {
    final number = value ?? 0;

    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }

    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number >= 10000 ? 0 : 1)}k';
    }

    return number.toString();
  }

  @override
  void onInit() {
    super.onInit();
    getComments();
  }
}
