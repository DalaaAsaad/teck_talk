import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/edit_blog_view_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/image_url_helper.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/drop_down_field.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/glass_input_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/cover_image_card.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/elevated_card.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/progress_step.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/publish_switch_tile.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/section_edit_card.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_picker_sheet.dart';

class EditBlogView extends GetView<EditBlogViewController> {
  const EditBlogView({super.key});

  static const List<String> _readingTimeOptions = [
    '3 min',
    '5 min',
    '10 min',
    '15 min',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
              child: ProgressSteps(
                steps: const ['Cover', 'Details', 'Publish'],
                currentStep: controller.currentStep,
              ),
            ),
            SizedBox(height: Responsive.hp(0.014)),
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedCard(
                      title: 'Cover Image',
                      child: Obx(() => _buildCoverImage()),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Blog Details',
                      child: Column(
                        children: [
                          GlassInputField(
                            controller: controller.titleController,
                            hintText: 'Article title',
                          ),
                          SizedBox(height: Responsive.hp(0.018)),
                          GlassInputField(
                            controller: controller.subtitleController,
                            hintText: 'Article subtitle',
                          ),
                          SizedBox(height: Responsive.hp(0.018)),
                          Obx(
                            () => DropdownField(
                              label: 'Reading Time',
                              value: controller.readingTime.value.isEmpty
                                  ? null
                                  : '${controller.readingTime.value} min',
                              items: _readingTimeOptions,
                              onChanged: (value) {
                                if (value == null) return;
                                controller.readingTime.value = value.replaceAll(
                                  ' min',
                                  '',
                                );
                              },
                            ),
                          ),
                          SizedBox(height: Responsive.hp(0.018)),
                          _buildTagsField(),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Sections',
                      child: _buildSections(context),
                    ),
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

  Widget _buildSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.sections.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.02)),
              child: Center(
                child: CustomText(
                  text: 'No sections yet',
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.muted,
                  fontSize: Responsive.sp(0.037),
                ),
              ),
            );
          }

          return Column(
            children: List.generate(controller.sections.length, (index) {
              final section = controller.sections[index];

              return SectionEditCard(
                index: index,
                displayTitle: section.title.isEmpty
                    ? 'New section'
                    : section.title,
                isExpanded: controller.expandedSectionIndex.value == index,
                titleController: controller.sectionTitleControllers[index],
                contentController: controller.sectionContentControllers[index],
                onToggleExpand: () => controller.toggleSection(index),
                onDelete: () => _confirmDeleteSection(context, index),
              );
            }),
          );
        }),
        SizedBox(height: Responsive.hp(0.01)),
        _buildAddSectionButton(),
      ],
    );
  }

  Widget _buildAddSectionButton() {
    return InkWell(
      onTap: controller.addSection,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.014)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Appcolor.accent.withOpacity(0.4),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              color: Appcolor.accent,
              size: Responsive.sp(0.05),
            ),
            SizedBox(width: Responsive.wp(0.015)),
            CustomText(
              text: 'Add Section',
              styleType: TextStyleType.CUSTOM,
              textColor: Appcolor.accent,
              fontSize: Responsive.sp(0.037),
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteSection(BuildContext context, int index) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.06)),
        child: Container(
          padding: EdgeInsets.all(Responsive.wp(0.055)),
          decoration: BoxDecoration(
            color: Appcolor.panel,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Appcolor.panelEdge),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Remove this section?',
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.046),
                fontWeight: FontWeight.w700,
                textColor: Appcolor.white,
              ),
              SizedBox(height: Responsive.hp(0.01)),
              CustomText(
                text:
                    'It will be removed when you tap "Save Changes". This cannot be undone after saving.',
                styleType: TextStyleType.BODY,
                textColor: Appcolor.muted,
              ),
              SizedBox(height: Responsive.hp(0.026)),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.hp(0.015),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Appcolor.panelEdge),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Cancel',
                          styleType: TextStyleType.SMALL,
                          fontWeight: FontWeight.w600,
                          textColor: Appcolor.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.wp(0.03)),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Get.back();
                        controller.deleteSection(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.hp(0.015),
                        ),
                        decoration: BoxDecoration(
                          color: Appcolor.danger,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Remove',
                          styleType: TextStyleType.SMALL,
                          fontWeight: FontWeight.w600,
                          textColor: Appcolor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildCoverImage() {
    Widget? preview;
    if (controller.newCoverImage.value != null) {
      preview = Image.file(
        File(controller.newCoverImage.value!.path),
        fit: BoxFit.cover,
      );
    } else if (controller.blogInfo.value?.coverImageUrl != null &&
        !controller.removeCoverImage.value) {
      final url = resolveImageUrl(controller.blogInfo.value!.coverImageUrl!);
      preview = Image.network(
        url ?? '',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Appcolor.panelEdge,
          alignment: Alignment.center,
          child: Icon(
            Icons.image_not_supported_rounded,
            color: Appcolor.muted,
            size: Responsive.sp(0.07),
          ),
        ),
      );
    }

    return CoverImageCard(
      hasImage: controller.hasCoverImage,
      imagePreview: preview,
      onPick: controller.pickCoverImage,
      onRemove: controller.removeExistingCoverImage,
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
            text: 'Edit blog',
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
          () => ElevatedButton(
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
    );
  }
}
