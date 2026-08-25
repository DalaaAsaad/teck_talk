import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/splash/constants/splash_constants.dart';

class ThinProgressLine extends StatefulWidget {
  const ThinProgressLine();

  @override
  State<ThinProgressLine> createState() => _ThinProgressLineState();
}

class _ThinProgressLineState extends State<ThinProgressLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: SplashConstants.progressAnimation,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.3,
      height: size.height * 0.01,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          color: Appcolor.panelEdge,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Align(
                alignment: Alignment(-1 + 2 * (_controller.value), 0),
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: LinearGradient(
                        colors: [
                          Appcolor.accent.withOpacity(0),
                          Appcolor.accent,
                          Appcolor.accent.withOpacity(0),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolor.accent.withOpacity(0.6),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
