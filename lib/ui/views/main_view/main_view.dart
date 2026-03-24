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
          actionsPadding: EdgeInsets.all(screenWidth(50)),
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
          ],
        ),
        backgroundColor: Appcolor.black_08,
        body: Stack(
          children: [
            body[_current_index],

            Positioned(
              bottom: screenWidth(70),
              left: screenWidth(70),
              right: screenWidth(100),
              child: Container(
                decoration: BoxDecoration(
                  color: Appcolor.Black_05,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  enableFeedback: false,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
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
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.article),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: "",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
