import 'package:get/route_manager.dart';
import 'package:tech_talk/Binding/account_binding.dart';
import 'package:tech_talk/Binding/blog_binding.dart';
import 'package:tech_talk/Binding/blog_view_binding.dart';
import 'package:tech_talk/Binding/change_pesonal_info_binding.dart';
import 'package:tech_talk/Binding/chat_bot_binding.dart';
import 'package:tech_talk/Binding/childreen_comment_binding.dart';
import 'package:tech_talk/Binding/comments_binding.dart';
import 'package:tech_talk/Binding/compiler_binding.dart';
import 'package:tech_talk/Binding/create_blog_binding.dart';
import 'package:tech_talk/Binding/create_post_binding.dart';
import 'package:tech_talk/Binding/edit_blog_binding.dart';
import 'package:tech_talk/Binding/edit_post_controller.dart';
import 'package:tech_talk/Binding/edit_profile_binding.dart';
import 'package:tech_talk/Binding/home_binding.dart';
import 'package:tech_talk/Binding/my_activity_binding.dart';
import 'package:tech_talk/Binding/notifications_binding.dart';
import 'package:tech_talk/Binding/otp_binding.dart';
import 'package:tech_talk/Binding/post_action_binding.dart';
import 'package:tech_talk/Binding/profile_binding.dart';
import 'package:tech_talk/Binding/road_map_view_binding.dart';
import 'package:tech_talk/Binding/road_maps_binding.dart';
import 'package:tech_talk/Binding/search_binding.dart';
import 'package:tech_talk/Binding/settings_binding.dart';
import 'package:tech_talk/Binding/signin_binding.dart';
import 'package:tech_talk/Binding/signup_binding.dart';
import 'package:tech_talk/Binding/splash_binding.dart';
import 'package:tech_talk/Binding/user_profile_binding.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/ui/views/Settings_view/settings_view.dart';
import 'package:tech_talk/ui/views/compiler/compiler.dart';
import 'package:tech_talk/ui/views/edit_blog/Edit_blog.dart';
import 'package:tech_talk/ui/views/edit_profile/edit_profile_view.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/change_personal_info_view.dart';
import 'package:tech_talk/ui/views/main_view/create_post/edit_post_view.dart';
import 'package:tech_talk/ui/views/my_activity.dart/my_activity.dart';
import 'package:tech_talk/ui/views/notifications/notifications_view.dart';
import 'package:tech_talk/ui/views/otp_register.dart/otp_register.dart';
import 'package:tech_talk/ui/views/public_user_profile/user_profile.dart';
import 'package:tech_talk/ui/views/sign_in/signin_view.dart';
import 'package:tech_talk/ui/views/sign_up/signup_view.dart';
import 'package:tech_talk/ui/views/blog_view/blog_view.dart';
import 'package:tech_talk/ui/views/chat_bot/chat_bot.dart';
import 'package:tech_talk/ui/views/childreen_comment.dart/childreen_comment_view.dart';
import 'package:tech_talk/ui/views/comments/comments.dart';
import 'package:tech_talk/ui/views/create_blog/create_blog.dart';
import 'package:tech_talk/ui/views/intro/intro.dart';
import 'package:tech_talk/ui/views/main_view/create_post/create_post.dart';
import 'package:tech_talk/ui/views/main_view/home/home.dart';
import 'package:tech_talk/ui/views/main_view/main_view.dart';
import 'package:tech_talk/ui/views/main_view/search/search_view.dart';
import 'package:tech_talk/ui/views/road_map_view/road_map_view.dart';
import 'package:tech_talk/ui/views/roadmaps/roadmaps.dart';
import 'package:tech_talk/ui/views/splash/splash.dart';

class AppPages {
  static final pagesView = [
    GetPage(
      name: AppRoutes.splash,
      page: () => Splash(),
      binding: SplashBinding(),
    ),
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
        PostActionBinding(),
        AccountBinding(),
        NotificationsBinding(),
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
    GetPage(
      name: AppRoutes.comments,
      page: () => const Comments(),
      binding: CommentsBinding(),
    ),
    GetPage(
      name: AppRoutes.childreenComments,
      page: () => const ChildreenComments(),
      binding: ChildreenCommentsBinding(),
    ),
    GetPage(
      name: AppRoutes.chatbot,
      page: () => const ChatBot(),
      binding: ChatBotBinding(),
    ),
    GetPage(
      name: AppRoutes.roadmaps,
      page: () => const RoadMaps(),
      binding: RoadMapsBinding(),
    ),
    GetPage(
      name: AppRoutes.RoadMapView,
      page: () => const RoadMapView(),
      binding: RoadMapViewBinding(),
    ),

    GetPage(
      name: AppRoutes.myActivity,
      page: () => const MyActivity(),
      binding: MyActivityBinding(),
    ),
    GetPage(
      name: AppRoutes.userProfile,
      page: () => const UserProfile(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.compiler,
      page: () => const Compiler(),
      binding: CompilerBinding(),
    ),
    GetPage(
      name: AppRoutes.editBlog,
      page: () => const EditBlogView(),
      binding: EditBlogBinding(),
    ),
    GetPage(
      name: AppRoutes.changePersonalInfo,
      page: () => const ChangePersonalInfoView(),
      binding: changePersonalInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.editPost,
      page: () => const EditPostView(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
  ];
}
