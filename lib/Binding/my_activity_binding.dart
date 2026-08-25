import 'package:get/get.dart';
import 'package:tech_talk/controllers/my_activity_controller.dart';

class MyActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityController>(() => ActivityController());
  }
}
