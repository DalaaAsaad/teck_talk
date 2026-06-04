import 'package:get/get.dart';
import 'package:teck_talk/core/data/repository/auth_repository.dart';
import 'package:teck_talk/core/data/repository/shared_pref.dart';
import 'package:teck_talk/core/data/responses/blogs_response.dart';

import 'package:teck_talk/ui/shared/shared_widget/app_snackbar.dart';

class BlogController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final RxBool isLoading = false.obs;
  final RxList<BlogModel> blogs = <BlogModel>[].obs;
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  Future<void> getBlogs() async {
    isLoading.value = true;
    final token = await _sharedPrefs.getAuthToken();
    try {
      final result = await _authRepository.getBlogs(token: token!);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (blogsResponse) {
          blogs.assignAll(blogsResponse.data);
        },
      );
    } catch (e) {
      AppSnackBar.error('An error occurred');
    } finally {
      isLoading.value = false;
    }
  }
}
