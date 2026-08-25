import 'package:get/get.dart';
import 'package:tech_talk/controllers/road_map_view_controller.dart';

class RoadMapViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoadMapViewController>(() => RoadMapViewController());
  }
}
