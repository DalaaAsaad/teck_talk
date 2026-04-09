import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/controllers/search_controller.dart';

class Search extends StatefulWidget {

  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final search_Controller controller = Get.put(search_Controller());
  @override
  void initState() {
    super.initState();

    final tag = Get.arguments;

    if (tag != null) {
      controller.setSearchFromTag(tag);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(28)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenWidth(28)),
              Container(
                height: screenWidth(8),
                decoration: BoxDecoration(
                  color: Appcolor.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SizedBox(width: screenWidth(23)),
                    Icon(Icons.search, color: Appcolor.yellow_70),
                    SizedBox(width: screenWidth(40)),
                    Expanded(
                      child: TextField(
                        controller: controller.textController,
                        onChanged: controller.onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              controller.searchText.value = '';
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth(60)),
              Expanded(
                child: Obx(() {
                  if (!controller.isSearching)
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Recent',
                              styleType: TextStyleType.CUSTOM,
                              fontSize: screenWidth(18),
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'See all',
                              styleType: TextStyleType.BODY,
                              textColor: Appcolor.yellow_70,
                            ),
                          ],
                        ),
                        SizedBox(height: screenWidth(25)),
                        Expanded(
                          child: ListView(
                            children: [
                              RecentItem(title: 'frontend'),
                              RecentItem(title: 'AI'),
                              RecentItem(title: 'API Calls'),
                            ],
                          ),
                        ),
                      ],
                    );
                  return DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        const TabBar(
                          indicatorColor: Appcolor.yellow_70,
                          labelColor: Appcolor.yellow_70,
                          unselectedLabelColor: Appcolor.gray_95,
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          tabs: [
                            Row(
                              children: [
                                Icon(Icons.article),
                                SizedBox(width: 5),
                                Tab(text: "Posts"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.person),
                                Tab(text: "Accounts"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.post_add),
                                Tab(text: "Blogs"),
                              ],
                            ),
                          ],
                        ),

                        Expanded(
                          child: TabBarView(
                            children: [
                              GridView.builder(
                                itemCount: 20,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                    ),
                                itemBuilder: (context, index) {
                                  return Container();
                                },
                              ),
                              GridView.builder(
                                itemCount: 20,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                    ),
                                itemBuilder: (context, index) {
                                  return Container();
                                },
                              ),
                              GridView.builder(
                                itemCount: 20,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                    ),
                                itemBuilder: (context, index) {
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentItem extends StatelessWidget {
  final String title;

  const RecentItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth(80)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, styleType: TextStyleType.BODY),
          Icon(Icons.close, color: Appcolor.white.withAlpha(200)),
        ],
      ),
    );
  }
}
