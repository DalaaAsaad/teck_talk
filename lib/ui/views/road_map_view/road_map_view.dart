import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/road_map_view_controller.dart';
import 'package:tech_talk/core/data/responses/road_map_details_response.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class RoadMapView extends GetView<RoadMapViewController> {
  const RoadMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.bg,
        appBar: _buildAppBar(context),
        body: Obx(() {
          if (controller.isLoading.value &&
              controller.roadMapDetails.value == null) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolor.accent),
            );
          }

          final details = controller.roadMapDetails.value?.data;
          final nodes = details?.nodes ?? [];

          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: Responsive.hp(0.015),
              left: Responsive.wp(0.04),
              right: Responsive.wp(0.04),

              bottom: Responsive.hp(0.12),
            ),
            children: [
              _RoadMapHeaderCard(
                title: details?.title ?? controller.roadMap.title,
                description:
                    details?.description ?? controller.roadMap.description,
                stagesCount: nodes.length,
              ),

              SizedBox(height: Responsive.hp(0.025)),

              for (var i = 0; i < nodes.length; i++)
                _StageTimelineItem(
                  stage: nodes[i],
                  isLast: i == nodes.length - 1,
                ),
            ],
          );
        }),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Appcolor.bg,
    elevation: 0,
    toolbarHeight: Responsive.hp(0.065),
    leading: IconButton(
      icon: Icon(
        Icons.chevron_left,
        color: Appcolor.white,
        size: Responsive.sp(0.075),
      ),
      onPressed: () => Navigator.maybePop(context),
    ),
  );
}

class _RoadMapHeaderCard extends StatelessWidget {
  final String title;
  final String description;
  final int stagesCount;

  const _RoadMapHeaderCard({
    required this.title,
    required this.description,
    required this.stagesCount,
  });

  @override
  Widget build(BuildContext context) {
    final initial = title.isNotEmpty ? title[0].toUpperCase() : '?';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.wp(0.04)),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.sp(0.045)),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Responsive.wp(0.11),
                height: Responsive.wp(0.11),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Appcolor.accent,
                  borderRadius: BorderRadius.circular(Responsive.sp(0.03)),
                ),
                child: Text(
                  initial,
                  style: TextStyle(
                    color: Appcolor.white,
                    fontSize: Responsive.sp(0.045),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              SizedBox(width: Responsive.wp(0.03)),

              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Appcolor.white,
                    fontSize: Responsive.sp(0.045),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          if (description.isNotEmpty) ...[
            SizedBox(height: Responsive.hp(0.015)),

            Text(
              description,
              style: TextStyle(
                color: Appcolor.muted,
                fontSize: Responsive.sp(0.034),
                height: 1.5,
              ),
            ),
          ],

          SizedBox(height: Responsive.hp(0.015)),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.025),
              vertical: Responsive.hp(0.007),
            ),
            decoration: BoxDecoration(
              color: Appcolor.accentDim,
              borderRadius: BorderRadius.circular(Responsive.sp(0.05)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.flag_rounded,
                  color: Appcolor.accent,
                  size: Responsive.sp(0.035),
                ),

                SizedBox(width: Responsive.wp(0.015)),

                Text(
                  '$stagesCount stages',
                  style: TextStyle(
                    color: Appcolor.accent,
                    fontSize: Responsive.sp(0.03),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StageTimelineItem extends StatelessWidget {
  final RoadMapNode stage;
  final bool isLast;

  const _StageTimelineItem({required this.stage, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Responsive.wp(0.09),
            child: Column(
              children: [
                Container(
                  width: Responsive.wp(0.07),
                  height: Responsive.wp(0.07),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Appcolor.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${stage.stepNumber}',
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: Responsive.sp(0.03),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: Responsive.wp(0.005),
                      margin: EdgeInsets.symmetric(
                        vertical: Responsive.hp(0.005),
                      ),
                      color: Appcolor.accentDim,
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: Responsive.wp(0.025)),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: Responsive.hp(0.02)),
              child: _StageCard(stage: stage),
            ),
          ),
        ],
      ),
    );
  }
}

class _StageCard extends StatelessWidget {
  final RoadMapNode stage;

  const _StageCard({required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.wp(0.035)),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.sp(0.04)),
        border: Border.all(color: Appcolor.panelEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stage.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.038),
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: Responsive.hp(0.012)),

          _ResourceRow(resource: stage),
        ],
      ),
    );
  }
}

class _ResourceRow extends GetView<RoadMapViewController> {
  final RoadMapNode resource;

  const _ResourceRow({required this.resource});

  String get _label {
    final uri = Uri.tryParse(resource.url);
    final host = uri?.host ?? '';

    if (host.isEmpty) {
      return 'Open resource';
    }

    final cleanHost = host.startsWith('www.') ? host.substring(4) : host;

    final name = cleanHost.split('.').first;

    if (name.isEmpty) {
      return 'Open resource';
    }

    return name[0].toUpperCase() + name.substring(1);
  }

  bool get _isVideo {
    final host = Uri.tryParse(resource.url)?.host.toLowerCase() ?? '';

    return host.contains('youtube') ||
        host.contains('youtu.be') ||
        host.contains('vimeo') ||
        resource.url.toLowerCase().endsWith('.mp4');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openUrl(resource.url),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.wp(0.025),
          vertical: Responsive.hp(0.012),
        ),
        decoration: BoxDecoration(
          color: Appcolor.bg,
          borderRadius: BorderRadius.circular(Responsive.sp(0.03)),
        ),
        child: Row(
          children: [
            Container(
              width: Responsive.wp(0.07),
              height: Responsive.wp(0.07),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isVideo ? Appcolor.danger : Appcolor.success,
                borderRadius: BorderRadius.circular(Responsive.sp(0.02)),
              ),
              child: Icon(
                _isVideo ? Icons.play_arrow_rounded : Icons.code_rounded,
                color: Appcolor.white,
                size: Responsive.sp(0.04),
              ),
            ),

            SizedBox(width: Responsive.wp(0.025)),

            Expanded(
              child: Text(
                _label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: Responsive.sp(0.03),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              color: Appcolor.muted,
              size: Responsive.sp(0.05),
            ),
          ],
        ),
      ),
    );
  }
}
