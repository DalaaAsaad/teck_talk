import 'package:get/get.dart';
import 'package:tech_talk/controllers/childreen_comments_controller.dart';

class ChildreenCommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildreenCommentsController>(
      () => ChildreenCommentsController(),
    );
  }
}
