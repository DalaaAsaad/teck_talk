import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/edit_post_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/glass_input_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/publish_switch_tile.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_picker_sheet.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/elevated_card.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/multiline_glass_field.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/post_photos_grid.dart';

class EditPostView extends GetView<EditPostController> {
  const EditPostView({super.key});

  static const List<String> _languages = [
    "Dart",
    "Java",
    "Python",
    "C++",
    "JavaScript",
    "other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.hp(0.008)),
                    ElevatedCard(
                      title: 'Post Content',
                      child: Column(
                        children: [
                          GlassInputField(
                            controller: controller.titleController,
                            hintText: 'Title',
                          ),
                          SizedBox(height: Responsive.hp(0.014)),
                          MultilineGlassField(
                            controller: controller.contentController,
                            hintText: "What's on your mind?",
                            maxLength: 2000,
                            minLines: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Photos',
                      child: Obx(
                        () => PostPhotosGrid(
                          photos: controller.photos,
                          deletingPhotoIds: controller.deletingPhotoIds,
                          isUploading: controller.isUploadingPhoto.value,
                          onRemove: controller.removePhoto,
                          onAdd: controller.pickAndUploadPhotos,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Code',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLanguageDropdown(),
                          SizedBox(height: Responsive.hp(0.014)),
                          _buildCodeBox(),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(title: 'Topics', child: _buildTagsField()),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Publish Settings',
                      child: Obx(
                        () => PublishSwitchTile(
                          isPublished: controller.isPublished.value,
                          onChanged: (value) =>
                              controller.isPublished.value = value,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSaveBar(),
    );
  }

  Widget _buildTagsField() {
    return Obx(() {
      final selectedNames = controller.availableTags
          .where((tag) => controller.selectedTagIds.contains(tag.id))
          .map((tag) => tag.name)
          .toList();

      return TagsField(
        selectedTagNames: selectedNames,
        onTap: () => showTagsPickerSheet(
          availableTags: controller.availableTags,
          selectedTagIds: controller.selectedTagIds,
          isLoadingTags: controller.isLoadingTags,
        ),
      );
    });
  }

  Widget _buildLanguageDropdown() {
    return Obx(
      () => DropdownMenu<String>(
        width: Responsive.wp(0.45),
        hintText: "Select Language",
        textStyle: TextStyle(
          color: Appcolor.white,
          fontSize: Responsive.sp(0.036),
          fontWeight: FontWeight.w600,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Appcolor.bg,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.03),
            vertical: Responsive.hp(0.01),
          ),
          hintStyle: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.036),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Appcolor.panelEdge),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Appcolor.panelEdge),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Appcolor.accent, width: 1.4),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Appcolor.panel),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Appcolor.panelEdge),
            ),
          ),
        ),
        initialSelection: controller.selectedLanguage.value.isEmpty
            ? null
            : controller.selectedLanguage.value,
        onSelected: (value) {
          if (value != null) controller.selectedLanguage.value = value;
        },
        dropdownMenuEntries: _languages
            .map(
              (v) => DropdownMenuEntry<String>(
                value: v,
                label: v,
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Appcolor.white),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCodeBox() {
    return Container(
      height: Responsive.hp(0.2),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.032),
        vertical: Responsive.hp(0.012),
      ),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        border: Border.all(color: Appcolor.panelEdge),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller.codeController,
        maxLines: null,
        style: TextStyle(
          color: Appcolor.white,
          fontFamily: 'monospace',
          fontSize: Responsive.sp(0.036),
        ),
        decoration: InputDecoration(
          hintText: "Paste your code here...",
          hintStyle: TextStyle(color: Appcolor.muted),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Responsive.wp(0.02),
        end: Responsive.wp(0.045),
        top: Responsive.hp(0.01),
        bottom: Responsive.hp(0.008),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Appcolor.white,
              size: Responsive.sp(0.05),
            ),
          ),
          CustomText(
            text: 'Edit post',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.05),
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveBar() {
    return Container(
      padding: EdgeInsets.only(
        left: Responsive.wp(0.045),
        right: Responsive.wp(0.045),
        top: Responsive.hp(0.014),
        bottom: Responsive.hp(0.024),
      ),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        border: Border(top: BorderSide(color: Appcolor.panelEdge)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: Responsive.hp(0.062),
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: controller.isSaved.value
                ? Container(
                    key: const ValueKey('saved'),
                    decoration: BoxDecoration(
                      color: Appcolor.success.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Appcolor.success.withOpacity(0.4),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_rounded,
                          color: Appcolor.success,
                          size: Responsive.sp(0.045),
                        ),
                        SizedBox(width: Responsive.wp(0.02)),
                        CustomText(
                          text: 'Saved',
                          styleType: TextStyleType.CUSTOM,
                          textColor: Appcolor.success,
                          fontSize: Responsive.sp(0.04),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    key: const ValueKey('save-button'),
                    onPressed: controller.isSaving.value
                        ? null
                        : controller.saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.accent,
                      disabledBackgroundColor: Appcolor.accent.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isSaving.value
                        ? SizedBox(
                            width: Responsive.wp(0.05),
                            height: Responsive.wp(0.05),
                            child: const CircularProgressIndicator(
                              color: Appcolor.white,
                              strokeWidth: 2.4,
                            ),
                          )
                        : CustomText(
                            text: 'Save Changes',
                            styleType: TextStyleType.CUSTOM,
                            textColor: Appcolor.white,
                            fontSize: Responsive.sp(0.04),
                            fontWeight: FontWeight.w700,
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}