import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/search_controller.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/search/widgets/post_card_search.dart';

class PostTab extends GetView<Search_Controller> {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _buildInlineFilters(),
        Expanded(child: _buildPostsList()),
      ],
    );
  }

  Widget _buildPostsList() {
    return Obx(() {
      final filteredPosts = controller.posts;

      // Show "No posts found" only after loading completes and posts are empty
      if (!controller.isLoading.value &&
          filteredPosts.isEmpty &&
          controller.isSearching) {
        return Center(
          child: CustomText(
            text: 'No posts found for this search',
            styleType: TextStyleType.BODY,
            textColor: Appcolor.gray_60,
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.only(bottom: screenWidth(6)),
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          return PostCardSearch(
            post: filteredPosts[index],
            onFavorite: () {},
            onComment: () {},
            onSaved: () {},
          );
        },
      );
    });
  }

  Widget _buildInlineFilters() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: controller.toggleFilters,
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: screenWidth(30)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "Apply filters",
                    textColor: Appcolor.yellow_70,
                    styleType: TextStyleType.BODY,
                  ),
                  SizedBox(width: screenWidth(80)),
                  Icon(
                    controller.isShowFilters.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Appcolor.yellow_70,
                    size: screenWidth(18),
                  ),
                ],
              ),
            ),
          ),
          if (controller.isShowFilters.value) ...[
            _buildFilterChips(),
            if (controller.selectedFilters.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: screenWidth(45)),
                child: Row(
                  children: [
                    CustomText(
                      text: '${controller.selectedFilters.length} selected',
                      styleType: TextStyleType.BODY,
                      textColor: Appcolor.gray_60,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: controller.clearSelectedFilters,
                      child: CustomText(
                        text: 'Clear',
                        styleType: TextStyleType.BODY,
                        textColor: Appcolor.yellow_70,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(top: screenWidth(30)),
      child: Wrap(
        spacing: screenWidth(55),
        runSpacing: screenWidth(55),
        children: controller.allFilters.map((filter) {
          final isSelected = controller.selectedFilters.contains(filter);
          return InkWell(
            onTap: () => controller.toggleFilter(filter),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(28),
                vertical: screenWidth(65),
              ),
              decoration: BoxDecoration(
                color: isSelected ? Appcolor.yellow_70 : Appcolor.yellow_90,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected
                      ? Appcolor.yellow_70
                      : Appcolor.yellow_90.withAlpha(180),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Appcolor.yellow_70.withAlpha(40),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: CustomText(
                text: filter,
                styleType: TextStyleType.BODY,
                textColor: Appcolor.black_08,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
