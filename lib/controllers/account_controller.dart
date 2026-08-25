import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class AccountController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  final RxBool isLoadingFollow = false.obs;

  Future<void> follow({required int userId, required bool isDel}) async {
    try {
      isLoadingFollow.value = true;

      final token = await _sharedPrefs.getAuthToken();

      if (token == null || token.isEmpty) {
        AppSnackBar.error('Token not found');
        return;
      }

      final result = await _authRepository.follow(
        token: token,
        userId: userId,
        isDel: isDel,
      );

      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (response) {
          print('isFollowing: ${response.data.isFollowing}');
          print('followersCount: ${response.data.followersCount}');
        },
      );
    } catch (e) {
      print('❌ Follow error: $e');
      AppSnackBar.error(e.toString());
    } finally {
      isLoadingFollow.value = false;
    }
  }
}
