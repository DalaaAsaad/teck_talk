import 'package:get/route_manager.dart';
import 'package:teck_talk/Binding/blog_binding.dart';
import 'package:teck_talk/Binding/blog_view_binding.dart';
import 'package:teck_talk/Binding/create_blog_binding.dart';
import 'package:teck_talk/Binding/create_post_binding.dart';
import 'package:teck_talk/Binding/edit_profile_binding.dart';
import 'package:teck_talk/Binding/home_binding.dart';
import 'package:teck_talk/Binding/otp_binding.dart';
import 'package:teck_talk/Binding/profile_binding.dart';
import 'package:teck_talk/Binding/search_binding.dart';
import 'package:teck_talk/Binding/signin_binding.dart';
import 'package:teck_talk/Binding/signup_binding.dart';
import 'package:teck_talk/app/my_routs.dart';
import 'package:teck_talk/ui/views/activity_user/activity_user.dart';
import 'package:teck_talk/ui/views/auth/otp_register.dart';
import 'package:teck_talk/ui/views/auth/signin_view.dart';
import 'package:teck_talk/ui/views/auth/signup_view.dart';
import 'package:teck_talk/ui/views/blog_view/blog_view.dart';
import 'package:teck_talk/ui/views/create_blog/create_blog.dart';
import 'package:teck_talk/ui/views/edit_profile/edit_profile.dart';
import 'package:teck_talk/ui/views/intro/intro.dart';
import 'package:teck_talk/ui/views/main_view/create_post/create_post.dart';
import 'package:teck_talk/ui/views/main_view/home/home.dart';
import 'package:teck_talk/ui/views/main_view/main_view.dart';
import 'package:teck_talk/ui/views/main_view/search/search_view.dart';
import 'package:teck_talk/ui/views/splash/splash.dart';

class AppPages {
  static final pagesView = [
    GetPage(name: AppRoutes.splash, page: () => Splash()),
    GetPage(
      name: AppRoutes.intro,
      page: () => Intro(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(name: AppRoutes.home, page: () => Home(), binding: HomeBinding()),

    GetPage(
      name: AppRoutes.mainView,
      page: () => MainView(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
      bindings: [
        HomeBinding(),
        SearchBinding(),
        CreatePostBinding(),
        BlogBinding(),
        ProfileBinding(),
      ],
    ),

    GetPage(
      name: AppRoutes.search,
      page: () => Search(),
      binding: SearchBinding(),
    ),

    GetPage(
      name: AppRoutes.signup,
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SignupView(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: AppRoutes.signin,
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => SigninView(),
      binding: SigninBinding(),
    ),

    GetPage(
      name: AppRoutes.otp,
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 300),
      page: () => OtpRegister(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.createPost,
      page: () => CreatePost(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfile(),
      binding: EditProfileBinding(),
    ),

    GetPage(name: AppRoutes.activityUser, page: () => ActivityUser()),

    GetPage(
      name: AppRoutes.createBlog,
      page: () => CreateBlog(),
      binding: CreateBlogBinding(),
    ),

    GetPage(
      name: AppRoutes.blogView,
      page: () => const BlogView(),
      binding: BlogViewBinding(),
    ),
   
  ];
}
