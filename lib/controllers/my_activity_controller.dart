import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/data/models/post_model.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/Activity_History_Response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class ActivityController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  final RxBool isLoading = false.obs;

  final Rxn<ActivityHistoryResponse> activityResponse =
      Rxn<ActivityHistoryResponse>();

  final int currentUserId = SharedPreferenceRepository().getUserId() ?? 0;

  final RxBool isOpeningActivity = false.obs;

  Future<void> getActivity() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final token = _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        AppSnackBar.error('Please sign in again');
        return;
      }

      final result = await _authRepository.getMyActivity(token: token);

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          activityResponse.value = response;
        },
      );
    } catch (e) {
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openActivity(ActivityData activity) async {
    if (isOpeningActivity.value) return;

    final type = activity.subject.type.toLowerCase();
    final id = activity.subject.id;

    if (id == 0) return;

    if (type.contains('blog')) {
      Get.toNamed(AppRoutes.blogView, arguments: id);
      return;
    }

    if (type.contains('post')) {
      isOpeningActivity.value = true;
      try {
        final token = _sharedPrefs.getAuthToken();
        if (token == null || token.isEmpty) {
          AppSnackBar.error('Please sign in again');
          return;
        }

        final result = await _authRepository.getInfoPost(token: token, id: id);

        result.fold((error) => AppSnackBar.error(error), (response) {
          final data = response.data;
          if (data == null) {
            AppSnackBar.error('Post not found');
            return;
          }

          final post = PostModel.fromJson(data.toJson());
          Get.toNamed(AppRoutes.comments, arguments: post);
        });
      } catch (e) {
        AppSnackBar.error('Something went wrong');
      } finally {
        isOpeningActivity.value = false;
      }
      return;
    }

  }

  @override
  void onInit() {
    super.onInit();
    getActivity();
  }
}
