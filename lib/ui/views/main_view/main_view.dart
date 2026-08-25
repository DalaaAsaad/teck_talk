import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/main_view/blog/blog.dart';
import 'package:tech_talk/ui/views/main_view/create_post/create_post.dart';
import 'package:tech_talk/ui/views/main_view/home/home.dart';

import 'package:tech_talk/ui/views/main_view/main_view_controller.dart';
import 'package:tech_talk/ui/views/main_view/profile/profile.dart';
import 'package:tech_talk/ui/views/main_view/search/search_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  static const double _navBarHeight = 52;
  static const double _navBarBottomOffset = 10;
  static const double _notchDepth = 10;
  static const double _dotSize = 7;
  static const double _topPad = 6;

  final List<Widget> body = [Home(), blog(), CreatePost(), Search(), Profile()];

  final controller = Get.put(MainViewController());

  final List<_NavItemData> _navItems = const [
    _NavItemData(icon: Icons.home_rounded, index: 0),
    _NavItemData(icon: Icons.article_outlined, index: 1),
    _NavItemData(icon: Icons.add_rounded, index: 2),
    _NavItemData(icon: Icons.search_rounded, index: 3),
    _NavItemData(icon: Icons.account_circle_rounded, index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Appcolor.panel,
          elevation: 0,
          title: Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/logo.svg',
                height: Responsive.sp(0.07),

                colorFilter: ColorFilter.mode(Appcolor.accent, BlendMode.srcIn),
              ),
              SizedBox(width: Responsive.wp(0.03)),
              Text(
                "Tech Talk",
                style: TextStyle(
                  fontSize: Responsive.sp(0.055),
                  fontWeight: FontWeight.bold,
                  color: Appcolor.accent,
                ),
              ),
            ],
          ),
          actions: [
            Obx(
              () => Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: Responsive.sp(0.09),
                      color: Appcolor.accent,
                    ),
                    onPressed: () {
                      controller.openNotifications();
                    },
                  ),
                  if (controller.unreadNotifications.value > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0895C),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          controller.unreadNotifications.value > 9
                              ? '9+'
                              : '${controller.unreadNotifications.value}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Appcolor.bg,
        body: Stack(
          children: [
            Obx(
              () => IndexedStack(index: controller.bodyIndex, children: body),
            ),
            Positioned(
              bottom: _navBarBottomOffset,
              left: Responsive.wp(0.03),
              right: Responsive.wp(0.03),
              child: SizedBox(
                height: _navBarHeight + _topPad,
                child: Obx(() {
                  final selectedIndex = controller.currentIndex.value;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = constraints.maxWidth / _navItems.length;
                      final targetX = itemWidth * selectedIndex + itemWidth / 2;

                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: targetX, end: targetX),
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeOutCubic,
                        builder: (context, bumpX, child) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                top: _topPad,
                                child: CustomPaint(
                                  size: Size(
                                    constraints.maxWidth,
                                    _navBarHeight,
                                  ),
                                  painter: _NotchedBarPainter(
                                    bumpX: bumpX,
                                    bumpWidth: itemWidth * 0.62,
                                    notchDepth: _notchDepth,
                                    fillColor: Appcolor.panel,
                                    borderColor: Appcolor.panelEdge,
                                  ),
                                ),
                              ),

                              Positioned(
                                left: bumpX - _dotSize / 2,
                                top: _topPad + _notchDepth / 2 - _dotSize / 2,
                                child: Container(
                                  width: _dotSize,
                                  height: _dotSize,
                                  decoration: BoxDecoration(
                                    color: Appcolor.accent,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Appcolor.accent.withOpacity(0.6),
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 0,
                                right: 0,
                                top: _topPad,
                                height: _navBarHeight,
                                child: Row(
                                  children: _navItems.map((item) {
                                    final bool isSelected =
                                        selectedIndex == item.index;

                                    return Expanded(
                                      child: _NavBarButton(
                                        icon: item.icon,
                                        isSelected: isSelected,
                                        onTap: () =>
                                            controller.changeTab(item.index),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final int index;

  const _NavItemData({required this.icon, required this.index});
}

class _NotchedBarPainter extends CustomPainter {
  final double bumpX;
  final double bumpWidth;
  final double notchDepth;
  final Color fillColor;
  final Color borderColor;

  static const double _corner = 22;

  _NotchedBarPainter({
    required this.bumpX,
    required this.bumpWidth,
    required this.notchDepth,
    required this.fillColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawShadow(path, Colors.black.withOpacity(0.3), 12, false);
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  Path _buildPath(Size size) {
    final double w = size.width;
    final double h = size.height;
    final double half = bumpWidth / 2;

    final double notchStart = (bumpX - half).clamp(_corner, w - _corner);
    final double notchEnd = (bumpX + half).clamp(_corner, w - _corner);
    final double dipX = bumpX.clamp(_corner, w - _corner);

    final path = Path();

    path.moveTo(0, _corner);
    path.quadraticBezierTo(0, 0, _corner, 0);

    path.lineTo(notchStart, 0);

    path.cubicTo(
      notchStart + half * 0.55,
      0,
      dipX - half * 0.55,
      notchDepth,
      dipX,
      notchDepth,
    );
    path.cubicTo(
      dipX + half * 0.55,
      notchDepth,
      notchEnd - half * 0.55,
      0,
      notchEnd,
      0,
    );

    path.lineTo(w - _corner, 0);
    path.quadraticBezierTo(w, 0, w, _corner);
    path.lineTo(w, h - _corner);
    path.quadraticBezierTo(w, h, w - _corner, h);
    path.lineTo(_corner, h);
    path.quadraticBezierTo(0, h, 0, h - _corner);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant _NotchedBarPainter oldDelegate) {
    return oldDelegate.bumpX != bumpX ||
        oldDelegate.bumpWidth != bumpWidth ||
        oldDelegate.notchDepth != notchDepth;
  }
}

class _NavBarButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? Appcolor.accent : Appcolor.muted;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: isSelected ? 1.1 : 1.0,
          child: Icon(icon, color: color, size: Responsive.sp(0.06)),
        ),
      ),
    );
  }
}
