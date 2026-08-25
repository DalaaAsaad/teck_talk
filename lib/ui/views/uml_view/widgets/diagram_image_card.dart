import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class DiagramImageCard extends StatelessWidget {
  const DiagramImageCard({super.key, required this.imageBytes});

  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Responsive.hp(0.55),
      decoration: BoxDecoration(
        color: Appcolor.panel,
        borderRadius: BorderRadius.circular(Responsive.sp(0.025)),
        border: Border.all(
          color: Appcolor.panelEdge,
          width: Responsive.sp(0.002),
        ),
      ),
      child: imageBytes != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.sp(0.022)),
              child: Image.memory(
                imageBytes!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _emptyState(),
              ),
            )
          : _emptyState(),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.image_outlined,
            color: Appcolor.muted,
            size: Responsive.sp(0.08),
          ),
          SizedBox(height: Responsive.hp(0.01)),
          Text(
            'Diagram ready',
            style: TextStyle(color: Appcolor.muted, fontSize: Responsive.sp(0.032)),
          ),
        ],
      ),
    );
  }
}