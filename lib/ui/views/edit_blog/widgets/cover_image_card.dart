import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// كارد صورة الغلاف الموحّد. بياخد [hasImage] و [imagePreview] (الويدجت
/// الجاهز للمعاينة - Image.file أو Image.network حسب الحالة) من الـ caller
/// حتى يضل الويدجت نفسه ما إلو علاقة بمصدر الصورة (ملف محلي أو رابط).
class CoverImageCard extends StatelessWidget {
  final bool hasImage;
  final Widget? imagePreview;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const CoverImageCard({
    super.key,
    required this.hasImage,
    required this.onPick,
    required this.onRemove,
    this.imagePreview,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasImage) {
      return InkWell(
        onTap: onPick,
        borderRadius: BorderRadius.circular(14),
        child: _DashedUploadBox(
          child: Container(
            width: double.infinity,
            height: Responsive.hp(0.2),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Responsive.wp(0.13),
                  height: Responsive.wp(0.13),
                  decoration: BoxDecoration(
                    color: Appcolor.accentDim,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.06),
                  ),
                ),
                SizedBox(height: Responsive.hp(0.014)),
                CustomText(
                  text: 'Add cover image',
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.white,
                  fontSize: Responsive.sp(0.038),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: Responsive.hp(0.004)),
                CustomText(
                  text: 'Tap to upload from gallery',
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.muted,
                  fontSize: Responsive.sp(0.031),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: Responsive.hp(0.2),
            child: imagePreview,
          ),
          Positioned(
            right: Responsive.wp(0.025),
            bottom: Responsive.hp(0.014),
            child: Row(
              children: [
                _ActionPill(
                  icon: Icons.edit_outlined,
                  label: 'Change',
                  color: Appcolor.accent,
                  onTap: onPick,
                ),
                SizedBox(width: Responsive.wp(0.02)),
                _ActionPill(
                  icon: Icons.delete_outline_rounded,
                  label: 'Remove',
                  color: Appcolor.danger,
                  onTap: onRemove,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.03),
            vertical: Responsive.hp(0.009),
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Appcolor.white, size: Responsive.sp(0.037)),
              SizedBox(width: Responsive.wp(0.01)),
              Text(
                label,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: Responsive.sp(0.03),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedUploadBox extends StatelessWidget {
  final Widget child;
  const _DashedUploadBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: Appcolor.panelEdge),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  _DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(14),
    );

    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}