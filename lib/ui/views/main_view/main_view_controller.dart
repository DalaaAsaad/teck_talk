import 'package:get/get.dart';
import 'package:tech_talk/controllers/blog_controller.dart';
import 'package:tech_talk/controllers/homecontroller.dart';
import 'package:tech_talk/controllers/profile_controller.dart';

class MainViewController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxInt unreadNotifications = 0.obs;

  int get bodyIndex {
    return currentIndex.value;
  }

  void changeTab(int index) {
    currentIndex.value = index;

    if (index == 2) {
      return;
    }

    refreshCurrentPage();
  }

  void refreshCurrentPage() {
    switch (currentIndex.value) {
      case 0:
        if (Get.isRegistered<Homecontroller>()) {
          Get.find<Homecontroller>().getPosts();
        }
        break;

      case 1:
        if (Get.isRegistered<BlogController>()) {
          Get.find<BlogController>().refreshblogs();
        }
        break;

      case 2:
        break;

      case 3:
    
        break;

      case 4:
        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().loadProfile();
        }
        break;
    }
  }

  void openCreatePost() {
    currentIndex.value = 2;
  }

  void openNotifications() {
    Get.toNamed('/notifications');
    unreadNotifications.value = 0;
  }
}
