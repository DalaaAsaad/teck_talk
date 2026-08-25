import 'package:get/get.dart';
import 'package:tech_talk/controllers/post_action_controller.dart';

class PostActionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostActionController>(() => PostActionController());
  }
}
