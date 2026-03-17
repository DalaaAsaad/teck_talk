
import 'package:get/get.dart';

double screenWidth(double percent) {
  if (Get.height > Get.width) {
    return Get.width / percent;
  } else {
    return Get.height / percent;
  }
}
