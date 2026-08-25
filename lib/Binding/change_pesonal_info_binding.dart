import 'package:get/get.dart';
import 'package:tech_talk/controllers/change_personal_info_controller.dart';

class changePersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePersonalInfoController>(
      () => ChangePersonalInfoController(),
    );
  }
}
