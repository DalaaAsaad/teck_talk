import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/recent_section.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/tab_bar_section.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Search_Controller controller = Get.put(Search_Controller());

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
                child: Stack(
                  children: [
                    Obx(
                      () => controller.showSearchResults.value
                          ? const TabBarSection()
                          : const RecentSection(),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? _buildLoadingOverlay()
                          : const SizedBox.shrink(),
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

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: Container(
        color: Appcolor.black_08.withAlpha(120),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Appcolor.yellow_70),
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
          SizedBox(width: screenWidth(40)),
          Expanded(
            child: TextField(
              controller: controller.textController,
              onChanged: controller.onSearchChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _handleSearch(),
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Appcolor.yellow_70),
                  onPressed: _handleSearch,
                ),
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

  Future<void> _handleSearch() async {
    final hasResults = await controller.performSearch();
    FocusScope.of(context).unfocus();

    if (!hasResults && mounted) {
      AppSnackBar.error("No results found for this search");
    }
  }
}
