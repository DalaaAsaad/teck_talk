import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/search_controller.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/recent_section.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/tab_bar_section.dart';

class Search extends StatefulWidget {
  const Search({super.key});

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
          padding: EdgeInsets.symmetric(horizontal: screenWidth(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenWidth(28)),
              _buildSearchBar(),
              SizedBox(height: screenWidth(60)),
              Expanded(
                child: Obx(
                  () => controller.isSearching
                      ? TabBarSection()
                      : RecentSection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
              onSubmitted: controller.saveCurrentSearchToRecent,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.clearSearch();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
