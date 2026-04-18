import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/core/data/repository/shared_pref.dart';
import 'package:teck_talk/core/data/models/accounts_model.dart';
import 'package:teck_talk/core/data/models/blog_model.dart';
import 'package:teck_talk/core/data/models/post_model.dart';

class search_Controller extends GetxController {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  var searchText = ''.obs;
  var isShowFilters = false.obs;
  final RxList<String> selectedFilters = <String>[].obs;
  final RxList<String> recentSearches = <String>[].obs;

  final List<String> allFilters = [
    "Frontend",
    "AI",
    "Mobile apps",
    "Problems",
    "API",
    "Backend",
  ];

  final List<PostModel> posts = [
    PostModel(
      imageProfile: "assets/images/png/profile.png",
      nameProfile: "Ahmad Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["flutter", "back End"],
      images: [
        "assets/images/png/imageTest.png",
        "assets/images/png/blog_image.png",
      ],
    ),
    PostModel(
      imageProfile: "assets/images/png/profile.png",
      nameProfile: "nay Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["front End", "back End"],
      images: [],
    ),
    PostModel(
      imageProfile: "assets/images/png/profile.png",
      nameProfile: "Ahmad Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["front End"],
      images: [
        "assets/images/png/imageTest.png",
        "assets/images/png/blog_image.png",
      ],
      code: """public class Main {
    public static void main(String[] args) {
        // طباعة رسالة ترحيبية
        System.out.println(\"مرحبا بك في برنامج الحساب!\");

        // تعريف رقمين
        int a = 5;
        int b = 7;

        // حساب المجموع
        int sum = a + b;

        // عرض النتيجة
        System.out.println(\"مجموع \" + a + \" و \" + b + \" = \" + sum);
    }
}""",
      codeLanguage: "java",
    ),
    PostModel(
      imageProfile: "assets/images/png/profile.png",
      nameProfile: "Ahmad Hassan",
      date: "2 day",
      textPost:
          "What's wrong with this code? Getting an error and can't figure out why 🤔",
      numFav: 2500,
      numComment: 300,
      numSaved: 12,
      tags: ["front End", "back End"],
      images: [],
    ),
  ];

  final List<AccountsModel> accounts = [
    AccountsModel(
      name: 'John Techson',
      username: 'John_Techson',
      imagePath: 'assets/images/png/profile.png',
    ),
    AccountsModel(
      name: 'Sarah Ethicist',
      username: 'sarah_ethicist',
      imagePath: 'assets/images/png/profile.png',
    ),
    AccountsModel(
      name: 'Mina Frontend',
      username: 'mina_frontend',
      imagePath: 'assets/images/png/profile.png',
    ),
    AccountsModel(
      name: 'Mina Frontend',
      username: 'mina_frontend',
      imagePath: 'assets/images/png/profile.png',
    ),
    AccountsModel(
      name: 'Mina Frontend',
      username: 'mina_frontend',
      imagePath: 'assets/images/png/profile.png',
    ),
    AccountsModel(
      name: 'Mina Frontend',
      username: 'mina_frontend',
      imagePath: 'assets/images/png/profile.png',
    ),
    AccountsModel(
      name: 'Mina Frontend',
      username: 'mina_frontend',
      imagePath: 'assets/images/png/profile.png',
    ),
  ];

  final List<BlogModel> blogs = [
    BlogModel(
      nameProfile: 'Hassan Ahmad',
      imageProfile: 'assets/images/png/profile.png',
      date: '2 day',
      titleBlog: 'Docker for Beginners: Stop Struggling',
      textBlog:
          'A step-by-step guide to containerize your first application without the headache...',
      tags: ['Front End', 'Problem'],
      imageBlog: 'assets/images/png/blog_image.png',
    ),
    BlogModel(
      nameProfile: 'Hassan Ahmad',
      imageProfile: 'assets/images/png/profile.png',
      date: '2 day',
      titleBlog: 'Clean Flutter Folder Structure',
      textBlog:
          'A practical way to organize features, widgets, and shared components in Flutter projects.',
      tags: ['Flutter', 'Architecture'],
      imageBlog: 'assets/images/png/blog_image.png',
    ),
    BlogModel(
      nameProfile: 'Hassan Ahmad',
      imageProfile: 'assets/images/png/profile.png',
      date: '2 day',
      titleBlog: 'API Design Tips for Better UX',
      textBlog:
          'Small API decisions can make a huge difference in how the UI feels and responds.',
      tags: ['Backend', 'API'],
      imageBlog: 'assets/images/png/blog_image.png',
    ),
  ];

  TextEditingController textController = TextEditingController();
  bool get isSearching => searchText.value.length >= 2;

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

  List<PostModel> get filteredPosts {
    final query = searchText.value.trim().toLowerCase();

    return posts.where((post) {
      final matchesQuery =
          query.isEmpty ||
          post.textPost.toLowerCase().contains(query) ||
          post.nameProfile.toLowerCase().contains(query) ||
          post.tags.any((tag) => tag.toLowerCase().contains(query));

      final matchesFilters =
          selectedFilters.isEmpty ||
          selectedFilters.any(
            (selected) => post.tags.any(
              (tag) => tag.toLowerCase() == selected.toLowerCase(),
            ),
          );

      return matchesQuery && matchesFilters;
    }).toList();
  }

  List<AccountsModel> get filteredAccounts {
    final query = searchText.value.trim().toLowerCase();

    return accounts.where((account) {
      final matchesQuery =
          query.isEmpty ||
          account.name.toLowerCase().contains(query) ||
          account.username.toLowerCase().contains(query);

      final matchesFilters =
          selectedFilters.isEmpty ||
          selectedFilters.any((selected) {
            final key = selected.toLowerCase();
            return account.name.toLowerCase().contains(key) ||
                account.username.toLowerCase().contains(key);
          });

      return matchesQuery && matchesFilters;
    }).toList();
  }

  List<BlogModel> get filteredBlogs {
    final query = searchText.value.trim().toLowerCase();

    return blogs.where((blog) {
      final matchesQuery =
          query.isEmpty ||
          blog.titleBlog.toLowerCase().contains(query) ||
          blog.textBlog.toLowerCase().contains(query) ||
          blog.nameProfile.toLowerCase().contains(query) ||
          blog.tags.any((tag) => tag.toLowerCase().contains(query));

      final matchesFilters =
          selectedFilters.isEmpty ||
          selectedFilters.any(
            (selected) => blog.tags.any(
              (tag) => tag.toLowerCase() == selected.toLowerCase(),
            ),
          );

      return matchesQuery && matchesFilters;
    }).toList();
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    _sharedPrefs.saveLastSearchQuery(value);
  }

  void clearSearch() {
    saveCurrentSearchToRecent();
    textController.clear();
    searchText.value = '';
    isShowFilters.value = false;
    selectedFilters.clear();
    _sharedPrefs.clearLastSearchQuery();
  }

  void setSearchFromTag(String tag) {
    textController.text = tag;
    searchText.value = tag;
    _sharedPrefs.saveLastSearchQuery(tag);
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
    _sharedPrefs.saveLastSearchQuery(term);
  }

  void selectRecentSearch(String term) {
    setSearchFromTag(term);
    saveCurrentSearchToRecent(term);
  }

  void removeRecentSearch(String term) {
    recentSearches.remove(term);
    _sharedPrefs.saveRecentSearches(recentSearches.toList());
  }

  void clearRecentSearches() {
    recentSearches.clear();
    _sharedPrefs.clearRecentSearches();
  }

  Future<void> _restoreSearchState() async {
    final savedRecent = await _sharedPrefs.getRecentSearches();
    final savedQuery = await _sharedPrefs.getLastSearchQuery();

    if (savedRecent.isNotEmpty) {
      recentSearches.assignAll(savedRecent);
    }

    if (savedQuery.isNotEmpty) {
      textController.text = savedQuery;
      searchText.value = savedQuery;
    }
  }
}
