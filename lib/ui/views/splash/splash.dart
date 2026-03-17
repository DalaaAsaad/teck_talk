import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';

import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/intro/intro.dart';

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
      duration: const Duration(seconds: 6),
    )..repeat();
    _timer = Timer(Duration(seconds: 3), () {
      Get.off(Intro());
    });
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
              Spacer(),
              // RotationTransition(
              //   turns: _controller,
              //   child: Container(
              //     padding: const EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.white.withOpacity(0.4),
              //           blurRadius: 40,
              //           spreadRadius: 5,
              //         ),
              //       ],
              //     ),
              //     child: SvgPicture.asset(
              //       "assets/images/svg/logo.svg",
              //       width: screenWidth(5),
              //     ),
              //   ),
              // ),
              SvgPicture.asset(
                "assets/images/svg/logo.svg",
                width: screenWidth(5),
              ),
              SizedBox(height: screenWidth(20)),
              CustomText(text: "Teck talk", styleType: TextStyleType.TITLE),
              Padding(
                padding: EdgeInsets.only(
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
