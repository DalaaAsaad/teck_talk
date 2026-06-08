import 'package:get/get.dart';
import 'package:tech_talk/controllers/comments_controller.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentsController>(() => CommentsController());
  }
}
