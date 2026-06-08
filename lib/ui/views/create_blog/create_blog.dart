import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/custom_widget/publish_draft_button_widget.dart';
import 'package:tech_talk/ui/shared/custom_widget/upload_image_container.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/controllers/create_blog_controller.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/content_section_card.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/add_section_button.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/drop_down_field.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/glass_input_field.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/section_label.dart';
import 'package:tech_talk/ui/views/create_blog/widgets/table_of_contents.dart';

class CreateBlog extends GetView<CreateBlogController> {
  const CreateBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black_08,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            screenWidth(18),
            screenWidth(18),
            screenWidth(18),
            screenWidth(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCancelButton(),
              SizedBox(height: screenWidth(18)),
              SectionLabel(text: 'Cover Image'),
              SizedBox(height: screenWidth(40)),
              UploadImageContainer(
                images: controller.selectedImages,
                text: "Tap to add cover image",
              ),
              SizedBox(height: screenWidth(22)),
              SectionLabel(text: 'Article Info'),
              SizedBox(height: screenWidth(40)),
              GlassInputField(
                controller: controller.titleController,
                hintText: 'Article title',
              ),
              SizedBox(height: screenWidth(14)),
              GlassInputField(
                controller: controller.subtitleController,
                hintText: 'Article subtitle',
              ),
              SizedBox(height: screenWidth(16)),
              buildDropDowns(),
              SizedBox(height: screenWidth(22)),
              SectionLabel(text: 'Table of Contents'),
              SizedBox(height: screenWidth(40)),
              buildTableOfContents(),
              SizedBox(height: screenWidth(25)),
              AddSectionButton(onTap: controller.addSection),
              SizedBox(height: screenWidth(12)),
              SectionLabel(text: 'Content'),
              SizedBox(height: screenWidth(40)),
              buildContentSections(),
              SizedBox(height: screenWidth(18)),
              buildPublishButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCancelButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: controller.cancel,
        child: CustomText(
          text: 'Cancel',
          textColor: Appcolor.white,
          fontSize: screenWidth(14),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDropDowns() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: DropdownField(
              label: 'Category',
              value: controller.selectedCategory.value,
              items: controller.categories,
              onChanged: (value) {
                if (value != null) {
                  controller.selectCategory(value);
                }
              },
            ),
          ),
          SizedBox(width: screenWidth(14)),
          Expanded(
            child: DropdownField(
              label: 'Reading Time',
              value: controller.selectedReadingTime.value,
              items: controller.readingTimes,
              onChanged: (value) {
                if (value != null) {
                  controller.selectReadingTime(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTableOfContents() {
    return Obx(
      () => Column(
        children: List.generate(
          controller.sections.length,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: screenWidth(30)),
            child: TableOfContents(
              index: index,
              title: controller.sections[index],
              isEditing: controller.editingIndices.contains(index),
              controller: controller.sectionControllers[index],
              canEdit: index != 0,
              onStartEdit: () {
                controller.startEditSection(index);
              },
              onSave: () {
                controller.saveSectionTitle(index);
              },
              onCancel: () {
                controller.cancelEditSection(index);
              },
              canDelete: index != 0,
              onDelete: () {
                controller.deleteSection(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContentSections() {
    return Obx(
      () => Column(
        children: List.generate(
          controller.sections.length,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: screenWidth(30)),
            child: ContentSectionCard(
              title: controller.sections[index],
              controller: controller.sectionContentControllers[index],
            ),
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
