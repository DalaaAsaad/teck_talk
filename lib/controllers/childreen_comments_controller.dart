import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class ChildreenCommentsController extends GetxController {
  final CommentModel comment = Get.arguments as CommentModel;
  final RxList<CommentModel> childremComments = <CommentModel>[].obs;
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    fetchChildComments();
  }

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
}
