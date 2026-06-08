import 'package:get/get.dart';
import 'package:tech_talk/controllers/signin_controller.dart';

class SigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SigninController());
  }
}
