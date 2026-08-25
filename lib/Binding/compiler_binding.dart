import 'package:get/get.dart';
import 'package:tech_talk/controllers/compiler_controller.dart';

class CompilerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompilerController>(() => CompilerController());
  }
}