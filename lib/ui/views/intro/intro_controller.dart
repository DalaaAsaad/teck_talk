import 'package:get/get.dart';

class IntroController extends GetxController {
  RxBool isPressed = false.obs;
  RxDouble currentPage = 0.0.obs;

  void navigateToMain() {
    Get.toNamed("/mainView");
  }
}
