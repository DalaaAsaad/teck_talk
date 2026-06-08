import 'package:get/get.dart';
import 'package:tech_talk/controllers/create_blog_controller.dart';

class CreateBlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBlogController>(() => CreateBlogController());
  }
}
