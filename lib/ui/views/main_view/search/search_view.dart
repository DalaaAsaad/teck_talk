import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/search_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_snackbar.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/recent_section.dart';
import 'package:tech_talk/ui/views/main_view/search/widgets/tab_bar_section.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Search_Controller controller = Get.put(Search_Controller());
  final FocusNode _focusNode = FocusNode();
  final RxBool _isFocused = false.obs;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    final tag = Get.arguments;
    if (tag != null) {
      controller.setSearchFromTag(tag);
    }

    _focusNode.addListener(() {
      _isFocused.value = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.bg,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.035)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.hp(0.01)),
              _buildSearchBar(),
              SizedBox(height: Responsive.hp(0.01)),
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

  Widget _buildSearchBar() {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        height: Responsive.hp(0.058),
        decoration: BoxDecoration(
          color: Appcolor.panel,
          borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
          border: Border.all(
            color: _isFocused.value ? Appcolor.accent : Appcolor.panelEdge,
            width: 1.2,
          ),
          boxShadow: _isFocused.value
              ? [
                  BoxShadow(
                    color: Appcolor.accent.withOpacity(0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            SizedBox(width: Responsive.wp(0.025)),
            IconButton(
              onPressed: _handleSearch,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: Responsive.sp(0.05),
              icon: Icon(
                Icons.search_rounded,
                color: _isFocused.value ? Appcolor.accent : Appcolor.muted,
                size: Responsive.sp(0.06),
              ),
            ),
            SizedBox(width: Responsive.wp(0.02)),
            Expanded(
              child: TextField(
                controller: controller.textController,
                focusNode: _focusNode,
                onChanged: _onSearchTextChanged,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _handleSearch(),
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: Responsive.sp(0.038),
                  fontWeight: FontWeight.w400,
                ),
                cursorColor: Appcolor.accent,
                cursorWidth: 1.5,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Appcolor.label,
                    fontSize: Responsive.sp(0.038),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Obx(() {
              if (!controller.hasSearchText.value) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: () {
                  _debounce?.cancel();
                  controller.clearSearch();
                  _focusNode.unfocus();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: Responsive.sp(0.05),
                icon: Icon(
                  Icons.close_rounded,
                  color: Appcolor.muted,
                  size: Responsive.sp(0.055),
                ),
              );
            }),
            SizedBox(width: Responsive.wp(0.02)),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LIVE SEARCH LISTENER
  // بيكتب → طلب تلقائي بعد فترة قصيرة (debounce)
  // بيمسح كل شي → رجوع فوري لـ Recent بدون طلب
  // ============================================================
  void _onSearchTextChanged(String value) {
    controller.onSearchChanged(value);

    _debounce?.cancel();

    if (value.trim().isEmpty) {
      controller.clearSearch();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 450), () {
      controller.performSearch(value);
    });
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Appcolor.bg.withOpacity(0.6),
          borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
        ),
        alignment: Alignment.center,
        child: SizedBox(
          width: Responsive.wp(0.07),
          height: Responsive.wp(0.07),
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Appcolor.accent,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSearch() async {
    _debounce?.cancel();
    final hasResults = await controller.performSearch();
    _focusNode.unfocus();
    if (!hasResults && mounted) {
      AppSnackBar.error("No results found for this search");
    }
  }
}
