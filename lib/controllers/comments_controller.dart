import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:tech_talk/core/data/responses/suggestions_folowed_response.dart';

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
  final FocusNode commentFocusNode = FocusNode();
  final RxBool showMentionList = false.obs;
  final RxString mentionQuery = ''.obs;
  final RxList<SuggestedUser> mentionUsers = <SuggestedUser>[].obs;
  final int? userId = SharedPreferenceRepository().getUserId();
  final RxBool isLoadingSuggestions = false.obs;
  final RxBool isPostOwner = false.obs;

  int get postId => post.id;

    PostModel get post {
    final args = Get.arguments;
    if (args is Map) return args['post'] as PostModel;
    return args as PostModel;
  }
 
  bool get showPostContent {
    final args = Get.arguments;
    if (args is Map) return args['showPost'] == true;
    return false;
  }
  Future<void> checkPostOwner() async {
    final currentUserId = await _sharedPrefs.getUserId();

    if (currentUserId == null) {
      isPostOwner.value = false;
      return;
    }

    isPostOwner.value = post.user.id == currentUserId;
  }

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

  Future<void> togglePinComment(CommentModel comment) async {
    try {
      final token = await _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        AppSnackBar.error('Authentication token not found');
        return;
      }

      final result = await _authRepository.highlightComment(
        token: token,
        commentId: comment.id.toString(),
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          comment.isHighlighted = response.data.isHighlighted;
          getComments();
          // AppSnackBar.success(response.message);
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
  }

  Future<void> toggleDelete(CommentModel comment) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.DeleteComment(
        id: comment.id,
        token: token!,
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          getComments();
        },
      );
    } catch (e) {
      print(e);
      AppSnackBar.error(e.toString());
    }
  }

  void resetForm() {
    typeController.clear();
    codeController.clear();

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

  @override
  void onInit() {
    super.onInit();
    typeController.addListener(_handleMention);

    checkPostOwner();
    getComments();
  }
}
