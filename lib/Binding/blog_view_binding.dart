import 'package:get/get.dart';
import 'package:tech_talk/controllers/blog_view_controller.dart';

class BlogViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogViewController>(() => BlogViewController());
  }
}
