import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/publish_draft_button_widget.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/create_blog_controller.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/code_section.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/content_input.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/image_section.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/profile_section.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/top_bar.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/topices_section.dart';

class CreateBlog extends GetView<CreateBlogController> {
  const CreateBlog({super.key});

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
              onDraft: controller.saveAsDraft,
              onPublish: controller.postBlog,
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
