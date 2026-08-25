import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_field.dart';
import 'package:tech_talk/ui/views/edit_blog/widgets/tags_picker_sheet.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/elevated_card.dart';

class TopicesSection extends GetView<CreatePostController> {
  const TopicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      title: "Topics",
      child: Obx(() {
        final selectedNames = controller.tags
            .where((tag) => controller.selectedTagIds.contains(tag.id))
            .map((tag) => tag.name)
            .toList();

        return TagsField(
          selectedTagNames: selectedNames,
          onTap: () => showTagsPickerSheet(
            availableTags: controller.tags,
            selectedTagIds: controller.selectedTagIds,
            isLoadingTags: controller.isTagsLoading,
          ),
        );
      }),
    );
  }
}