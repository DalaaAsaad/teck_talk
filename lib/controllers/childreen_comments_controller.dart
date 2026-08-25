import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/core/data/responses/suggestions_folowed_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class ChildreenCommentsController extends GetxController {
  final CommentModel comment = Get.arguments as CommentModel;
  final TextEditingController typeController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final RxList<CommentModel> childremComments = <CommentModel>[].obs;
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();
  final FocusNode commentFocusNode = FocusNode();
  final RxBool showMentionList = false.obs;
  final RxString mentionQuery = ''.obs;
  final RxList<SuggestedUser> mentionUsers = <SuggestedUser>[].obs;
  final RxBool isLoadingSuggestions = false.obs;
  int get postId => (Get.arguments as List)[0];

  Future<void> fetchChildComments() async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.getChildreenComments(
        id: comment.id,
        token: token!,
        page: 1,
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (commentsResponse) {
          childremComments.assignAll(commentsResponse.data.children);
        },
      );
    } finally {}
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

          childremComments.refresh();
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

          childremComments.refresh();
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
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

  void commentPost(CommentModel comment) async {
    if (typeController.text.isEmpty && codeController.text.isEmpty) {
      return;
    }
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.createCommentPost(
        token: token!,
        body: typeController.text,
        postId: comment.postId ?? 0,
        code: codeController.text,
        codeLanguage: '',
        parentId: comment.id,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          AppSnackBar.success(response.message);
          fetchChildComments();
          resetForm();
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> getMentionSuggestions(String letters) async {
    try {
      isLoadingSuggestions.value = true;

      final token = await _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        return;
      }

      final result = await _authRepository.suggestionFolowed(
        token: token,
        letters: letters,
      );

      result.fold(
        (failure) {
          print('Suggestion error: $failure');
          mentionUsers.clear();
        },
        (response) {
          mentionUsers.assignAll(response.data);
        },
      );
    } catch (e) {
      print('Suggestion error: $e');
      mentionUsers.clear();
    } finally {
      isLoadingSuggestions.value = false;
    }
  }

  void _handleMention() {
    final text = typeController.text;
    final cursorPosition = typeController.selection.baseOffset;

    if (cursorPosition < 0) return;

    final textBeforeCursor = text.substring(0, cursorPosition);

    final match = RegExp(r'@(\w*)$').firstMatch(textBeforeCursor);

    if (match != null) {
      final query = match.group(1) ?? '';

      if (query.length >= 2) {
        mentionQuery.value = query;
        showMentionList.value = true;

        getMentionSuggestions(query);
      } else {
        showMentionList.value = false;
        mentionUsers.clear();
      }
    } else {
      showMentionList.value = false;
      mentionUsers.clear();
    }
  }

  void selectMentionUser(SuggestedUser user) {
    final text = typeController.text;
    final cursorPosition = typeController.selection.baseOffset;

    if (cursorPosition < 0) return;

    final textBeforeCursor = text.substring(0, cursorPosition);

    final match = RegExp(r'@(\w*)$').firstMatch(textBeforeCursor);

    if (match == null) return;

    final start = match.start;

    final newText = text.replaceRange(
      start,
      cursorPosition,
      '@${user.username} ',
    );

    typeController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: start + user.username.length + 2,
      ),
    );

    showMentionList.value = false;
    mentionUsers.clear();
    mentionQuery.value = '';
  }

  @override
  void onClose() {
    typeController.removeListener(_handleMention);

    typeController.dispose();
    codeController.dispose();
    commentFocusNode.dispose();

    super.onClose();
  }

  void resetForm() {
    typeController.clear();
    codeController.clear();
  }

  void onInit() {
    super.onInit();
    typeController.addListener(_handleMention);
    fetchChildComments();
  }
}
