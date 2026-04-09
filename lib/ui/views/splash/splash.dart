import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  Timer? _timer;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Get.offNamed("/intro");
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage("assets/images/jpg/backGround.jpg"), context);
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              RotationTransition(
                turns: _controller,
                child: Container(
                  padding: EdgeInsets.all(screenWidth(16)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Appcolor.white.withAlpha(100),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    "assets/images/svg/logo.svg",
                    width: screenWidth(5),
                  ),
                ),
              ),
              SizedBox(height: screenWidth(20)),
              CustomText(text: "Teck talk", styleType: TextStyleType.TITLE),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: screenWidth(10),
                  top: screenWidth(1.1),
                ),
                child: CustomText(
                  text: "v 1.0.0",
                  styleType: TextStyleType.SMALL,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
