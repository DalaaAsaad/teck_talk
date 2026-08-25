import 'package:get/get.dart';

class Responsive {
  static double get width => Get.width;

  static double get height => Get.height;

  static double get shortest =>
      Get.width < Get.height ? Get.width : Get.height;

  static double wp(double percent) {
    return width * percent;
  }


  static double hp(double percent) {
    return height * percent;
  }

  static double sp(double percent) {
    return shortest * percent;
  }
}