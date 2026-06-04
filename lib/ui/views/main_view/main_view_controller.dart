import 'package:get/get.dart';
import 'package:teck_talk/controllers/blog_controller.dart';
import 'package:teck_talk/controllers/homecontroller.dart';
import 'package:teck_talk/controllers/profile_controller.dart';

class MainViewController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    final previousIndex = currentIndex.value;
    currentIndex.value = index;

    if (index == 0 && previousIndex != 0) {
      Get.find<Homecontroller>().getPosts();
    }

    if (index == 1 &&
        previousIndex != 1 &&
        Get.isRegistered<BlogController>()) {
      Get.find<BlogController>().getBlogs();
    }

    if (index == 4 && Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().loadProfile();
    
    }
  }
}
