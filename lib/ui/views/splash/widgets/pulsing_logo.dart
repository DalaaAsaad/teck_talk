import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/splash/constants/splash_constants.dart';

class PulsingLogo extends StatefulWidget {
  final double size;
  final Widget child;
  const PulsingLogo({required this.size, required this.child});

  @override
  State<PulsingLogo> createState() => _PulsingLogoState();
}

class _PulsingLogoState extends State<PulsingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ringScale;
  late Animation<double> _ringOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: SplashConstants.logoAnimation,
      vsync: this,
    )..repeat();

    _ringScale = Tween<double>(
      begin: 1.0,
      end: 1.35,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _ringOpacity = Tween<double>(
      begin: 0.35,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 1.6,
      height: widget.size * 1.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // breathing ring
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _ringScale.value,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Appcolor.accent.withOpacity(_ringOpacity.value),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
          // logo circle
          Container(
            width: widget.size,
            height: widget.size,
            padding: EdgeInsets.all(widget.size * 0.2),
            decoration: BoxDecoration(
              color: Appcolor.panel,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Appcolor.accent.withOpacity(0.28),
                  blurRadius: 50,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
