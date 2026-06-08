import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';

class IntroController extends GetxController {
  RxBool isPressed = false.obs;
  RxDouble currentPage = 0.0.obs;

  void navigateToSignin() {
    Get.toNamed(AppRoutes.signup);
  }
}
