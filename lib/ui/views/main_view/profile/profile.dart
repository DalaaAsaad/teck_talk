import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth(40)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "UserName",
                            styleType: TextStyleType.CUSTOM,
                            fontSize: screenWidth(20),
                            fontWeight: FontWeight.w300,
                          ),
                          Icon(Icons.more_vert, color: Appcolor.gray_95),
                        ],
                      ),
                      SizedBox(height: screenWidth(40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: screenWidth(10),
                            child: Image.asset(
                              "assets/images/png/profile.png",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: "nameProfile",
                                    styleType: TextStyleType.CUSTOM,
                                    fontSize: screenWidth(20),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizedBox(width: 40),
                                  Container(
                                    height: screenWidth(20),
                                    width: screenWidth(5),
                                    margin: EdgeInsets.all(screenWidth(80)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Appcolor.white,
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: "Expert",
                                        styleType: TextStyleType.SMALL,
                                        textColor: Appcolor.black_08,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              CustomText(
                                text: "100 posts      100 folowers    50 blogs",
                                styleType: TextStyleType.CUSTOM,
                                fontSize: screenWidth(30),
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      CustomText(
                        text:
                            "Software Engineer with expertise in full-stack development. I build reliable systems, write clean code, and never stop learning.",
                        styleType: TextStyleType.CUSTOM,
                        fontSize: screenWidth(30),
                        textColor: Appcolor.white.withAlpha(150),
                      ),
                      xpBar(),

                      // السوشال ميديا
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/png/facebook.png",
                            width: 40,
                          ),
                          Image.asset("assets/images/png/insta.png", width: 40),
                          Image.asset(
                            "assets/images/png/Twitter.png",
                            color: Appcolor.white,
                            width: 40,
                          ),
                          Image.asset(
                            "assets/images/png/reddit.png",
                            width: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },

          body: Column(
            children: [
              TabBar(
                indicatorColor: Appcolor.yellow_70,
                labelColor: Appcolor.yellow_70,
                unselectedLabelColor: Appcolor.gray_95,
                tabs: [
                  Tab(icon: Icon(Icons.grid_view_rounded)),
                  Tab(icon: Icon(Icons.bookmark_border)),
                ],
              ),

              // 🔹 المحتوى
              Expanded(
                child: TabBarView(
                  children: [
                    // Posts
                    GridView.builder(
                      itemCount: 20,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),

                    // Saved
                    GridView.builder(
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey,
                          child: Icon(Icons.bookmark, color: Colors.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget xpBar() {
  double currentXP = 8644;
  double maxXP = 10000;

  double progress = currentXP / maxXP;

  return LayoutBuilder(
    builder: (context, constraints) {
      double width = constraints.maxWidth;

      return Column(
        children: [
          SizedBox(
            height: 30,
            child: Stack(
              children: [
                Positioned(
                  left: (width * progress) - 20,
                  child: Text(
                    "${currentXP.toInt()} xp",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Appcolor.white.withAlpha(180),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Appcolor.yellow_70,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0 xp",
                style: TextStyle(color: Colors.white54, fontSize: 10),
              ),
              Text(
                "$maxXP xp",
                style: TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ],
          ),
        ],
      );
    },
  );
}
