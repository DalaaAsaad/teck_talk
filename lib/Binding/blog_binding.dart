import 'package:get/get.dart';
import 'package:tech_talk/controllers/blog_controller.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogController>(() => BlogController());
  }
}
