import 'package:get/get.dart';
import 'package:tech_talk/controllers/homecontroller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Homecontroller>(() => Homecontroller());
  }
}
