import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/account_controller.dart';
import 'package:tech_talk/controllers/post_action_controller.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/models/user_general_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/blog_search_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class Search_Controller extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();
  final int currentUserId = SharedPreferenceRepository().getUserId() ?? 0;
  var searchText = ''.obs;
  var isShowFilters = false.obs;
  final RxBool isLoading = false.obs;
  final RxList<String> selectedFilters = <String>[].obs;
  final RxList<String> recentSearches = <String>[].obs;
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxList<UserGeneralModel> accounts = <UserGeneralModel>[].obs;
  final RxList<BlogSearchModel> blogs = <BlogSearchModel>[].obs;
  final RxBool hasSearchText = false.obs;
  final PostActionController postActionController =
      Get.find<PostActionController>();
  final AccountController controller = Get.find<AccountController>();
  final List<String> allFilters = [
    "Frontend",
    "AI",
    "Mobile apps",
    "Problems",
    "API",
    "Backend",
  ];

  TextEditingController textController = TextEditingController();
  bool get isSearching => searchText.value.length >= 2;
  final RxBool showSearchResults = false.obs;

  @override
  void onInit() {
    super.onInit();
    _restoreSearchState();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

  void clearSearch() {
    saveCurrentSearchToRecent();
    textController.clear();
    searchText.value = '';
    showSearchResults.value = false;
    isShowFilters.value = false;
    selectedFilters.clear();
    posts.clear();
    accounts.clear();
    blogs.clear();
    _sharedPrefs.clearLastSearchQuery();
    textController.clear();
    hasSearchText.value = false;
    showSearchResults.value = false;
  }

  void setSearchFromTag(String tag) {
    textController.text = tag;
    performSearch(tag);
  }

  void toggleFilters() {
    isShowFilters.value = !isShowFilters.value;
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  void clearSelectedFilters() {
    selectedFilters.clear();
  }

  void saveCurrentSearchToRecent([String? rawValue]) {
    final term = (rawValue ?? searchText.value).trim();

    if (term.length < 2) return;

    recentSearches.removeWhere(
      (item) => item.toLowerCase() == term.toLowerCase(),
    );

    recentSearches.insert(0, term);

    if (recentSearches.length > 10) {
      recentSearches.removeRange(10, recentSearches.length);
    }

    _sharedPrefs.saveRecentSearches(recentSearches.toList());
  }

  void selectRecentSearch(String term) {
    textController.text = term;
    performSearch(term);
  }

  void removeRecentSearch(String term) {
    recentSearches.remove(term);
    _sharedPrefs.saveRecentSearches(recentSearches.toList());
  }

  void clearRecentSearches() {
    recentSearches.clear();
    _sharedPrefs.clearRecentSearches();
  }

  Future<bool> performSearch([String? rawValue]) async {
    final term = (rawValue ?? textController.text).trim();

    if (term.length < 2) {
      posts.clear();
      accounts.clear();
      blogs.clear();
      showSearchResults.value = false;
      return false;
    }

    searchText.value = term;

    saveCurrentSearchToRecent(term);

    return _fetchSearchResults(term);
  }

  Future<void> _restoreSearchState() async {
    final savedRecent = await _sharedPrefs.getRecentSearches();

    if (savedRecent.isNotEmpty) {
      recentSearches.assignAll(savedRecent);
    }
  }

  Future<void> refreshSearchTab() async {
    final query = searchText.value.trim();

    if (query.length < 2) {
      return;
    }

    final token = await _sharedPrefs.getAuthToken();

    if (token == null || token.isEmpty) {
      return;
    }

    try {
      final result = await _authRepository.getSearch(
        query: query,
        tab: 'posts',
        page: 1,
        token: token,
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
      print('❌ refreshSearchTab error: $e');
    }
  }

  Future<void> toggleFavorite(PostModel post) async {
    await postActionController.likePost(post);
    await refreshSearchTab();
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

    await refreshSearchTab();
  }

  Future<void> toggleDelete(PostModel post) async {
    await postActionController.DeletePost(post);
    await refreshSearchTab();
  }

  // Future<void> toggleFollow(UserGeneralModel account) async {
  //   final wasFollowing = account.isFollowing;

  //   await controller.follow(userId: account.id, isDel: wasFollowing);

  //   account.isFollowing = !wasFollowing;
  //   accounts.refresh();
  // }

  Future<bool> _fetchSearchResults(String query) async {
    final token = await _sharedPrefs.getAuthToken();

    isLoading.value = true;

    try {
      // Run API calls and minimum delay in parallel
      final results = await Future.wait([
        _authRepository.getSearch(
          query: query,
          tab: 'posts',
          page: 1,
          token: token!,
        ),

        _authRepository.getSearch(
          query: query,
          tab: 'users',
          page: 1,
          token: token,
        ),

        _authRepository.getSearch(
          query: query,
          tab: 'blogs',
          page: 1,
          token: token,
        ),
        // Ensure loading shows for at least 500ms
        Future.delayed(const Duration(milliseconds: 500)),
      ]);

      final postsResult = results[0];
      final usersResult = results[1];
      final blogsResult = results[2];

      postsResult.fold(
        (_) => posts.clear(),
        (response) => posts.assignAll(response.data),
      );

      usersResult.fold(
        (_) => accounts.clear(),
        (response) => accounts.assignAll(response.data),
      );

      blogsResult.fold(
        (_) => blogs.clear(),
        (response) => blogs.assignAll(response.data),
      );

      final hasAnyResults =
          posts.isNotEmpty || accounts.isNotEmpty || blogs.isNotEmpty;
      showSearchResults.value = hasAnyResults;
      return hasAnyResults;
    } finally {
      isLoading.value = false;
    }
  }
}
