import 'package:get/get.dart';
import 'package:teck_talk/ui/views/comments/comments.dart';

class Homecontroller extends GetxController {
  var isFavorit = false.obs;
  var isComment = false.obs;
  var isSaved = false.obs;
  void toggleFavorite() {
    isFavorit.value = !isFavorit.value;
  }

  void toggleComment() {
    isComment.value = !isComment.value;
    Get.to(()=>Comments());
  }

  void toggleSaved() {
    isSaved.value = !isSaved.value;
  }
}
