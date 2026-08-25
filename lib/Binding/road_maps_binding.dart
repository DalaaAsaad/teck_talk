import 'package:get/get.dart';
import 'package:tech_talk/controllers/road_maps_controller.dart';

class RoadMapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoadMapsController>(() => RoadMapsController());
  }
}
