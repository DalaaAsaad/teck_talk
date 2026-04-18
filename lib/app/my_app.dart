import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:teck_talk/Binding/create_blog_binding.dart';
import 'package:teck_talk/Binding/home_binding.dart';
import 'package:teck_talk/Binding/search_binding.dart';
import 'package:teck_talk/Binding/signup_binding.dart';
import 'package:teck_talk/ui/views/auth/signup_view.dart';
import 'package:teck_talk/ui/views/intro/intro.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/create_blog.dart';
import 'package:teck_talk/ui/views/main_view/home/home.dart';
import 'package:teck_talk/ui/views/main_view/main_view.dart';
import 'package:teck_talk/ui/views/main_view/search/search_view.dart';
import 'package:teck_talk/ui/views/splash/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/SignupView',
      getPages: [
        GetPage(name: '/splash', page: () => Splash()),
        GetPage(
          name: '/intro',
          page: () => Intro(),
          transition: Transition.circularReveal,
          transitionDuration: Duration(milliseconds: 1000),
        ),
        GetPage(name: '/home', page: () => Home(), binding: HomeBinding()),
        GetPage(
          name: '/mainView',
          transition: Transition.circularReveal,
          transitionDuration: Duration(milliseconds: 1000),
          page: () => MainView(),
          bindings: [HomeBinding(), SearchBinding(), CreateBlogBinding()],
        ),

        GetPage(
          name: '/search',
          page: () => Search(),
          binding: SearchBinding(),
        ),
        GetPage(
          name: '/SignupView',
          page: () => SignupView(),
          binding: SignupBinding(),
        ),
        GetPage(
          name: '/createBlog',
          page: () => CreateBlog(),
          binding: CreateBlogBinding(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
