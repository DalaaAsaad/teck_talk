import 'package:get/get.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostController>(() => CreatePostController());
  }
}
