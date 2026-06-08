import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Search_Controller>(() => Search_Controller());
  }
}
