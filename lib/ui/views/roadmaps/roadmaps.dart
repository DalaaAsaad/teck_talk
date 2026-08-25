import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/road_maps_controller.dart';
import 'package:tech_talk/ui/shared/custom_widget/road_map_card.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class RoadMaps extends GetView<RoadMapsController> {
  const RoadMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading.value && controller.listRoadMaps.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Appcolor.accent),
          );
        }

        if (controller.listRoadMaps.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: Appcolor.muted,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No road maps yet',
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Check back later for new learning paths.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Appcolor.muted, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
          itemCount: controller.listRoadMaps.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Get.toNamed(
                    AppRoutes.RoadMapView,
                    arguments: controller.listRoadMaps[index],
                  );
                },
                child: RoadMapCard(
                  roadMap: controller.listRoadMaps[index],
                  index: index,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Appcolor.bg,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: Appcolor.white, size: 28),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Road Maps',
        style: TextStyle(
          color: Appcolor.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      centerTitle: false,
    );
  }
}
