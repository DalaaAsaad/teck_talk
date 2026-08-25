import 'package:get/get.dart';
import 'package:tech_talk/controllers/edit_blog_view_controller.dart';

class EditBlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditBlogViewController>(() => EditBlogViewController());
  }
}
