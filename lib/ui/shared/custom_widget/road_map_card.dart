import 'package:flutter/material.dart';
import 'package:tech_talk/core/data/responses/list_road_maps_response.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class RoadMapCard extends StatelessWidget {
  const RoadMapCard({super.key, required this.roadMap, required this.index});

  final RoadMap roadMap;
  final int index;
  static const List<Color> _palette = [
    Appcolor.accent,
    Appcolor.success,
    Appcolor.danger,
  ];
  static const List<IconData> _icons = [
    Icons.code,
    Icons.dns_outlined,
    Icons.smartphone_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final Color color = _palette[index % _palette.length];
    final IconData icon = _icons[index % _icons.length];

    return Container(
      width: Responsive.wp(0.2),
      height: Responsive.hp(0.15),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.panelEdge, width: 1),
      ),
      padding: EdgeInsetsDirectional.all(Responsive.sp(0.03)),
      child: Row(
        children: [
          Container(
            width: Responsive.wp(0.2),
            height: Responsive.hp(0.1),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: Responsive.sp(0.1)),
          ),
          SizedBox(width: Responsive.sp(0.03)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  roadMap.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Appcolor.white,
                    fontSize: Responsive.sp(0.05),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Responsive.sp(0.01)),
                Text(
                  roadMap.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Appcolor.muted,
                    fontSize: Responsive.sp(0.03),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.sp(0.03)),
          Icon(
            Icons.chevron_right,
            color: Appcolor.label,
            size: Responsive.sp(0.1),
          ),
        ],
      ),
    );
  }
}
