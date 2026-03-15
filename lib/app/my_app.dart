import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:teck_talk/ui/views/splash/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash());
  }
}
