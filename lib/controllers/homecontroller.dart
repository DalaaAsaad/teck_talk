import 'package:get/get.dart';
import 'package:teck_talk/core/data/models/post_model.dart';
import 'package:teck_talk/ui/views/comments/comments.dart';

class Homecontroller extends GetxController {
  var isFavorit = false.obs;
  var isComment = false.obs;
  var isSaved = false.obs;
  void toggleFavorite(PostModel post) {
    post.isFavorite.value = !post.isFavorite.value;
  }

  void toggleComment(PostModel post) {
    post.isComment.value = !post.isComment.value;
    Get.bottomSheet(
      Comments(),
      isScrollControlled: true,
      enableDrag: true,
      enterBottomSheetDuration: Duration(milliseconds: 400),
      exitBottomSheetDuration: Duration(milliseconds: 300),
    );
  }

  void toggleSaved(PostModel post) {
    post.isSaved.value = !post.isSaved.value;
  }
}
