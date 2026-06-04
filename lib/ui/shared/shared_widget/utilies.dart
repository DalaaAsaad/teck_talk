import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teck_talk/ui/shared/shared_widget/app_snackbar.dart';

double screenWidth(double percent) {
  if (Get.height > Get.width) {
    return Get.width / percent;
  } else {
    return Get.height / percent;
  }
}

Future<void> pickImages(List<XFile> selectedImages) async {
  final ImagePicker _picker = ImagePicker();
  PermissionStatus status = await Permission.photos.status;
  if (!status.isGranted) {
    PermissionStatus requestStatus = await Permission.photos.request();
    if (!requestStatus.isGranted) {
      AppSnackBar.error('Cannot access gallery.', title: 'Permission denied');
      return;
    }
  }
  try {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      selectedImages.addAll(images);
    }
  } catch (e) {
    AppSnackBar.error('Failed to pick images: $e');
  }
}

  void removeImage(int index, List<XFile> selectedImages) {
    selectedImages.removeAt(index);
  }
