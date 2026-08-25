import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';

double screenWidth(double percent) {
  if (Get.height > Get.width) {
    return Get.width * percent;
  } else {
    return Get.height * percent;
  }
}

double screenHeight(double percent) {
  if (Get.height > Get.width) {
    return Get.height * percent;
  } else {
    return Get.width * percent;
  }
}



void removeImage(int index, List<XFile> selectedImages) {
  selectedImages.removeAt(index);
}
