import 'package:get/get.dart';

class CommentsController extends RxController {
  RxBool isFavorite = false.obs;
  RxBool isLike = false.obs;
  RxBool isDislike = false.obs;
  void toggleFavorit() {
    isFavorite.value = !isFavorite.value;
  }

  void toggleLike() {
    isLike.value = !isLike.value;
  }

  void toggleDislike() {
    isDislike.value = !isDislike.value;
  }
}
