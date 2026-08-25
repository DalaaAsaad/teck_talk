import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/create_blog_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/custom_widget/publish_draft_button_widget.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/add_section_button.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/drop_down_field.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/glass_input_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/accourding_awitch_card.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/cover_image_card.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/elevated_card.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/progress_step.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_picker_sheet.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/published_button.dart';

class CreateBlog extends GetView<CreateBlogController> {
  const CreateBlog({super.key});

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
                steps: const ['Cover', 'Details', 'Content'],
                currentStep: controller.currentStep,
              ),
            ),
            SizedBox(height: Responsive.hp(0.014)),
            Expanded(
              child: SingleChildScrollView(
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.wp(0.045),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedCard(
                      title: 'Cover Image',
                      child: Obx(
                        () => CoverImageCard(
                          hasImage: controller.selectedImages.isNotEmpty,
                          imagePreview: controller.selectedImages.isNotEmpty
                              ? Image.file(
                                  File(controller.selectedImages.first.path),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          onPick: controller.pickCoverImage,
                          onRemove: controller.removeCoverImage,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Article Info',
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
                          _buildReadingTimeDropdown(),
                          SizedBox(height: Responsive.hp(0.018)),
                          _buildTagsField(),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.hp(0.02)),
                    ElevatedCard(
                      title: 'Content',
                      child: Column(
                        children: [
                          _buildAccordionSections(),
                          SizedBox(height: Responsive.hp(0.012)),
                          AddSectionButton(onTap: controller.addSection),
                        ],
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: Responsive.wp(0.045),
          right: Responsive.wp(0.045),
          bottom: Responsive.hp(0.02),
        ),
        child: buildPublishButton(),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Responsive.wp(0.045),
        end: Responsive.wp(0.045),
        top: Responsive.hp(0.01),
        bottom: Responsive.hp(0.008),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'Create blog',
            styleType: TextStyleType.CUSTOM,
            fontSize: Responsive.sp(0.05),
            fontWeight: FontWeight.w700,
            textColor: Appcolor.white,
          ),
          TextButton(
            onPressed: controller.cancel,
            child: CustomText(
              text: 'Cancel',
              textColor: Appcolor.muted,
              fontSize: Responsive.sp(0.035),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadingTimeDropdown() {
    return Obx(
      () => DropdownField(
        label: 'Reading Time',
        value: controller.selectedReadingTime.value,
        items: controller.readingTimes,
        onChanged: (value) {
          if (value != null) controller.selectReadingTime(value);
        },
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

  Widget _buildAccordionSections() {
    return Obx(
      () => Column(
        children: List.generate(
          controller.sections.length,
          (index) => AccordionSectionCard(
            index: index,
            title: controller.sections[index],
            isExpanded: controller.expandedIndex.value == index,
            isEditingTitle: controller.editingIndices.contains(index),
            titleController: controller.sectionControllers[index],
            contentController: controller.sectionContentControllers[index],
            canDelete: index != 0,
            onToggleExpand: () => controller.toggleSection(index),
            onStartEditTitle: () => controller.startEditSection(index),
            onSaveTitle: () => controller.saveSectionTitle(index),
            onDelete: () => controller.deleteSection(index),
          ),
        ),
      ),
    );
  }

  Widget buildPublishButton() {
    return PublishDraftButtonWidget(
      onDraft: controller.saveDraft,
      onPublish: controller.publishBlog,
      selectedIndex: controller.selectedIndex,
      onSelected: controller.selectButton,
    );
  }
}