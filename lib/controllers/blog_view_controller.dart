import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/blog_info_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class BlogViewController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final RxBool isLoading = false.obs;
  final RxBool isSaved = false.obs;
  final RxBool isFavorite = false.obs;
  final RxInt likesCount = 0.obs;
  final RxInt viewsCount = 0.obs;
  final RxInt bookmarksCount = 0.obs;
  final Rxn<BlogInfoData> blogInfo = Rxn<BlogInfoData>();

  int? get blogId {
    final arguments = Get.arguments;
    if (arguments is int) return arguments;
    if (arguments is String) return int.tryParse(arguments);
    return null;
  }
//* load blog info
  Future<void> loadBlogInfo() async {
    final id = blogId;
    if (id == null) {
      AppSnackBar.error('Invalid blog id');
      return;
    }

    isLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final result = await _authRepository.getInfoBlog(token: token, id: id);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          blogInfo.value = response.data;
        },
      );
    } catch (e) {
      AppSnackBar.error('An error occurred');
    } finally {
      isLoading.value = false;
    }
  }


//* like blog method
  void likeBlog(BlogInfoData blog) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.likeBlog(id: blog.id, token: token!);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          blog.isLikedByUser = !blog.isLikedByUser;
          if (blog.isLikedByUser) {
            blog.likesCount += 1;
          } else {
            blog.likesCount -= 1;
          }
          blogInfo.refresh();
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error(e.toString());
    }
  }
  void toggleFavorite(BlogInfoData blog) {
    likeBlog(blog);
  }

//*  saved blog method

void toggleSaved(BlogInfoData blog) {
    if (!blog.isSaved) {
      savedRequest(blog);
    } else {
      removeSaved(blog);
    }
  }

  void savedRequest(BlogInfoData blog) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.savePostOrBlog(
        id: blog.id,
        type: "blog",
        token: token!,
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          blog.isSaved = true;
          blogInfo.refresh();
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error(e.toString());
    }
  }

  void removeSaved(BlogInfoData blog) async {
    try {
      final token = await _sharedPrefs.getAuthToken();
      final result = await _authRepository.deleteSaved(
        id: blog.id,
        type: "blog",
        token: token!,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          blog.isSaved = false;
          blogInfo.refresh();
        },
      );
    } catch (e) {
      print(e.toString());
      AppSnackBar.error(e.toString());
    }
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
    loadBlogInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
