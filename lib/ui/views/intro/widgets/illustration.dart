import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/intro/widgets/floating_badge.dart';

class _BadgeSpec {
  final IconData icon;
  final String label;
  final double dx;
  final double dy;
  const _BadgeSpec({
    required this.icon,
    required this.label,
    required this.dx,
    required this.dy,
  });
}

class Illustration extends StatelessWidget {
  final String type;
  const Illustration({required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient glow behind everything
          Container(
            width: Responsive.wp(0.5),
            height: Responsive.hp(0.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Appcolor.accent.withOpacity(0.18), Colors.transparent],
              ),
            ),
          ),

          // Outer decorative ring
          Container(
            width: Responsive.wp(0.5),
            height: Responsive.hp(0.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Appcolor.accent.withOpacity(0.12),
                width: 1,
              ),
            ),
          ),
          Container(
            width: Responsive.wp(0.38),
            height: Responsive.hp(0.38),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Appcolor.accent.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),

          // Central icon card
          Container(
            width: Responsive.wp(0.3),
            height: Responsive.wp(0.3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Appcolor.panel,
              border: Border.all(color: Appcolor.panelEdge),
              boxShadow: [
                BoxShadow(
                  color: Appcolor.accent.withOpacity(0.3),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(child: _iconFor(type)),
          ),

          // Small floating badges
          ..._badges(type),
        ],
      ),
    );
  }

  Widget _iconFor(String type) {
    switch (type) {
      case 'logo':
        return SvgPicture.asset(
          'assets/images/svg/logo.svg',
          width: Responsive.sp(0.15),
          colorFilter: const ColorFilter.mode(Appcolor.accent, BlendMode.srcIn),
        );
      case 'light':
        return Icon(
          Icons.lightbulb_rounded,
          color: Appcolor.accent,
          size: Responsive.sp(0.15),
        );
      default:
        return Icon(
          Icons.build_rounded,
          color: Appcolor.accent,
          size: Responsive.sp(0.15),
        );
    }
  }

  List<Widget> _badges(String type) {
    final items = <_BadgeSpec>[];

    switch (type) {
      case 'logo':
        items.addAll([
          _BadgeSpec(
            icon: Icons.people_rounded,
            label: 'Community',
            dx: -120,
            dy: -50,
          ),
          _BadgeSpec(icon: Icons.code_rounded, label: 'Code', dx: 85, dy: -30),
          _BadgeSpec(
            icon: Icons.forum_rounded,
            label: 'Discuss',
            dx: 50,
            dy: 70,
          ),
        ]);
        break;
      case 'light':
        items.addAll([
          _BadgeSpec(
            icon: Icons.bug_report_rounded,
            label: 'Debug',
            dx: -85,
            dy: -45,
          ),
          _BadgeSpec(
            icon: Icons.share_rounded,
            label: 'Share',
            dx: 80,
            dy: -55,
          ),
          _BadgeSpec(
            icon: Icons.trending_up_rounded,
            label: 'Grow',
            dx: -60,
            dy: 65,
          ),
        ]);
        break;
      default:
        items.addAll([
          _BadgeSpec(
            icon: Icons.article_rounded,
            label: 'Articles',
            dx: -108,
            dy: -40,
          ),
          _BadgeSpec(
            icon: Icons.smart_toy_rounded,
            label: 'AI Help',
            dx: 80,
            dy: -50,
          ),
          _BadgeSpec(
            icon: Icons.bookmark_rounded,
            label: 'Save',
            dx: 55,
            dy: 72,
          ),
        ]);
    }

    return items
        .map(
          (b) => Positioned(
            left:
                MediaQueryData.fromView(
                      WidgetsBinding.instance.window,
                    ).size.width /
                    2 +
                b.dx -
                36,
            top: 130 + b.dy,
            child: FloatingBadge(icon: b.icon, label: b.label),
          ),
        )
        .toList();
  }
}
