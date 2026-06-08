import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class ActivityTabs extends StatelessWidget {
  const ActivityTabs();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            indicatorColor: Appcolor.yellow_70,
            labelColor: Appcolor.yellow_70,
            unselectedLabelColor: Appcolor.gray_95,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border_rounded),
                    SizedBox(width: screenWidth(35)),
                    CustomText(
                      text: 'Likes',
                      styleType: TextStyleType.CUSTOM,
                      fontSize: screenWidth(20),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mode_comment_outlined),
                    SizedBox(width: screenWidth(35)),
                    CustomText(
                      text: 'Comments',
                      styleType: TextStyleType.CUSTOM,
                      fontSize: screenWidth(20),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: TabBarView(
              children: [
                GridView.builder(
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Container(color: Colors.red);
                  },
                ),

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
    );
  }
}
