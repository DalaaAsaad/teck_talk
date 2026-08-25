import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/post_action_controller.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class Homecontroller extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMore = true.obs;
  final RxList<PostModel> posts = <PostModel>[].obs;
  final ScrollController scrollController = ScrollController();
  final int currentUserId = SharedPreferenceRepository().getUserId() ?? 0;
  final PostActionController postActionController =
      Get.put<PostActionController>(PostActionController());
  Future<void> getPosts({int page = 1, bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore.value) {
        return;
      }
      if (!hasMore.value) {
        return;
      }
      isLoadingMore.value = true;
    } else {
      if (isLoading.value) {
        return;
      }
      isLoading.value = true;
    }
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.getPosts(page: page, token: token!);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (postsResponse) {
          final newPosts = postsResponse.data;
          if (!loadMore) {
            posts.assignAll(newPosts);
          } else {
            posts.addAll(newPosts);
          }
          currentPage.value = page;
          if (newPosts.isEmpty) {
            hasMore.value = false;
          } else {
            hasMore.value = true;
          }
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      if (loadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  Future<void> nextPage() async {
    if (isLoading.value) {
      return;
    }
    if (isLoadingMore.value) {
      return;
    }
    if (!hasMore.value) {
      return;
    }
    final next = currentPage.value + 1;
    await getPosts(page: next, loadMore: true);
  }

  Future<void> refreshPosts() async {
    currentPage.value = 1;
    hasMore.value = true;
    await getPosts(page: 1, loadMore: false);
  }

  void toggleFavorite(PostModel post) {
    postActionController.likePost(post);
    refreshPosts();
  }

  void toggleComment(PostModel post) {
    Get.toNamed(AppRoutes.comments, arguments: post);
    refreshPosts();
  }

  void toggleSaved(PostModel post) {
    if (!post.isSaved) {
      postActionController.savedRequest(post);
      refreshPosts();
    } else {
      postActionController.removeSaved(post);
      refreshPosts();
    }
  }

  void toggleDelete(PostModel post) {
    postActionController.DeletePost(post);
    refreshPosts();
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (!scrollController.hasClients) return;
      final position = scrollController.position;
      if (position.pixels >= position.maxScrollExtent - 300) {
        nextPage();
      }
    });
    getPosts(page: 1, loadMore: false);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
