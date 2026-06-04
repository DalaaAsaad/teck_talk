import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:teck_talk/core/data/repository/shared_pref.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SharedPreferenceRepository _sharedPrefs = SharedPreferenceRepository();

  @override
  void initState() {
    super.initState();
    _navigateFromSplash();
  }

  Future<void> _navigateFromSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }

    final isLoggedIn = _sharedPrefs.isLoggedIn();
    if (isLoggedIn) {
      print(_sharedPrefs.getAuthToken());
      print(_sharedPrefs.getUserUserName());
      Get.offAllNamed('/mainView');
      return;
    }

    Get.offAllNamed('/intro');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage("assets/images/jpg/backGround.jpg"), context);
  }

  @override
  void dispose() {
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
              Container(
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
              SizedBox(height: screenWidth(20)),
              CustomText(text: "Tech Talk", styleType: TextStyleType.TITLE),
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
