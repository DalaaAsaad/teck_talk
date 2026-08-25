import 'package:get/state_manager.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/list_road_maps_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

class RoadMapsController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final RxBool isLoading = false.obs;
  final RxList<RoadMap> listRoadMaps = <RoadMap>[].obs;
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  @override
  void onInit() {
    super.onInit();
    getListRoadMaps();
  }

  Future<void> getListRoadMaps() async {
    isLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();

      if (token == null) {
        AppSnackBar.error('Session expired. Please log in again.');
        return;
      }

      final result = await _authRepository.getListRoadMaps(token: token);
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (postsResponse) {
          listRoadMaps.value = postsResponse.data;
        },
      );
    } catch (e) {
      AppSnackBar.error('Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}