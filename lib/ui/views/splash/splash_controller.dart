import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/ui/views/splash/constants/splash_constants.dart';

class SplashController extends GetxController {
  final SharedPreferenceRepository repository = SharedPreferenceRepository();

  Future<void> navigate() async {
    await Future.delayed(SplashConstants.navigationDelay);
    if (repository.isLoggedIn()) {
      Get.offAndToNamed(AppRoutes.mainView);
    } else {
      Get.offAllNamed(AppRoutes.intro);
    }
  }
}
