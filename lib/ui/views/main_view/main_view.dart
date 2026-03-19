import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/blog/blog.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/create_blog.dart';
import 'package:teck_talk/ui/views/main_view/home/home.dart';
import 'package:teck_talk/ui/views/main_view/profile/profile.dart';
import 'package:teck_talk/ui/views/main_view/search/search.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _current_index = 0;
  List<Widget> body = const [Home(), Blog(), CreateBlog(), Search(), Profile()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Appcolor.black_08,
          elevation: 0,
          title: Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/logo.svg',
                height: screenWidth(10),
              ),
              SizedBox(width: 10),
              CustomText(text: "TeckTalk", styleType: TextStyleType.SUBTITLE),
            ],
          ),

          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                size: screenWidth(10),
                color: Appcolor.yellow_70,
              ),
              onPressed: () {},
            ),

            IconButton(
              icon: Icon(
                Icons.menu,
                size: screenWidth(10),
                color: Appcolor.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Appcolor.black_08,
        body: body[_current_index],

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: screenWidth(300),

              color: Appcolor.white.withValues(alpha: 0.2),
            ),
            BottomNavigationBar(
              enableFeedback: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Appcolor.black_08,

              selectedItemColor: Appcolor.yellow_70,
              unselectedItemColor: Appcolor.white,

              showSelectedLabels: false,
              showUnselectedLabels: false,

              currentIndex: _current_index,
              onTap: (value) {
                setState(() {
                  _current_index = value;
                });
              },

              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: screenWidth(10)),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article, size: screenWidth(10)),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline, size: screenWidth(10)),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: screenWidth(10)),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle, size: screenWidth(10)),
                  label: "",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
