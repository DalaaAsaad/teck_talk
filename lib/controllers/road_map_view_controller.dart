import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/auth_repository.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/data/responses/list_road_maps_response.dart';
import 'package:tech_talk/core/data/responses/road_map_details_response.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadMapViewController extends GetxController {
  late final RoadMap roadMap;
  final AuthRepository _authRepository = AuthRepository();
  final RxBool isLoading = false.obs;
  final Rxn<RoadMapDetailsResponse> roadMapDetails =
      Rxn<RoadMapDetailsResponse>();
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  @override
  void onInit() {
    super.onInit();
    roadMap = Get.arguments;
    getRoadMapDetails();
  }

  Future<void> getRoadMapDetails() async {
    isLoading.value = true;
    try {
      final token = await _sharedPrefs.getAuthToken();
      if (token == null || token.isEmpty) {
        AppSnackBar.error('You need to be logged in to view this road map.');
        return;
      }

      final result = await _authRepository.getInfoRoadMaps(
        token: token,
        roadMapId: roadMap.id,
      );
      result.fold(
        (failure) {
          AppSnackBar.error(failure);
        },
        (roadMapDetailsResponse) {
          roadMapDetails.value = roadMapDetailsResponse;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      AppSnackBar.error('This resource link looks invalid.');
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      AppSnackBar.error('Could not open the resource link.');
    }
  }
}
