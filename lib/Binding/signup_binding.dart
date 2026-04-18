import 'package:get/get.dart';
import 'package:teck_talk/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
  }
}
