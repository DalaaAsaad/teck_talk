import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/controllers/homecontroller.dart';
import 'package:teck_talk/ui/views/main_view/home/widgets/float_button.dart';
import 'package:teck_talk/ui/views/main_view/home/widgets/foating_pager_header.dart';
import 'package:teck_talk/ui/views/main_view/home/widgets/list_posts_body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Homecontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black_08,
      floatingActionButton: FloatButton(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Appcolor.black_08),
            Column(children: [FloatingPagerHeader(), ListPostsBody()]),
          ],
        ),
      ),
    );
  }
}
