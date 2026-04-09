import 'package:get/get.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/create_blog_controller.dart';

class CreateBlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBlogController>(() => CreateBlogController());
  }
}