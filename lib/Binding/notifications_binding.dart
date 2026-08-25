import 'package:get/get.dart';
import 'package:tech_talk/controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    // permanent: true + put (مش lazyPut) - حتى الكونترولر ينبني فوراً
    // لحظة فتح mainView (وبالتالي onInit تبعو يستدعي connect() فوراً)،
    // بدل ما ينتظر أول widget يستدعي Get.find عليه.
    Get.put<NotificationsController>(
      NotificationsController(),
      permanent: true,
    );
  }
}
