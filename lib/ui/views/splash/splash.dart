import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/splash/constants/splash_constants.dart';
import 'package:tech_talk/ui/views/splash/splash_controller.dart';
import 'package:tech_talk/ui/views/splash/widgets/floating_orbs.dart';
import 'package:tech_talk/ui/views/splash/widgets/pulsing_logo.dart';
import 'package:tech_talk/ui/views/splash/widgets/thin_progress_line.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: SplashConstants.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.25, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _animationController.forward();

    Get.find<SplashController>().navigate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: Stack(
        children: [
          // Drifting glow orbs
          const Positioned.fill(child: FloatingOrbs()),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with pulsing glow ring
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: PulsingLogo(
                        size: Responsive.sp(0.4),
                        child: SvgPicture.asset(
                          "assets/images/svg/logo.svg",
                          colorFilter: const ColorFilter.mode(
                            Appcolor.accent,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.hp(0.01)),
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Appcolor.white, Appcolor.accent],
                            ).createShader(bounds),
                            child: Text(
                              'Tech Talk',
                              style: TextStyle(
                                color: Appcolor.white,
                                fontSize: Responsive.sp(0.08),
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          SizedBox(height: Responsive.hp(0.005)),
                          Text(
                            'v 1.0.0',
                            style: TextStyle(
                              color: Appcolor.muted,
                              fontSize: Responsive.sp(0.03),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.hp(0.15)),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const ThinProgressLine(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
