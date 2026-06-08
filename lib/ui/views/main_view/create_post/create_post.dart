import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/ui/shared/custom_widget/publish_draft_button_widget.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/code_section.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/content_input.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/image_section.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/profile_section.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/top_bar.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/topices_section.dart';

class CreatePost extends GetView<CreatePostController> {
  const CreatePost({super.key});

  static double sectionSpacing = screenWidth(20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.black_08,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(),
            SizedBox(height: screenWidth(sectionSpacing)),
            ProfileSection(),
            SizedBox(height: screenWidth(sectionSpacing)),
            ContentInput(),
            SizedBox(height: screenWidth(sectionSpacing)),
            ImageSection(),
            SizedBox(height: screenWidth(sectionSpacing)),
            CodeSection(),
            SizedBox(height: screenWidth(sectionSpacing)),
            TopicesSection(),
            SizedBox(height: screenWidth(sectionSpacing)),
            PublishDraftButtonWidget(
              onDraft: controller.createDraft,
              onPublish: controller.creatPost,
              selectedIndex: controller.selectedIndex,
              onSelected: controller.selectButton,
            ),
            SizedBox(height: screenWidth(6)),
          ],
        ),
      ),
    );
  }
}
