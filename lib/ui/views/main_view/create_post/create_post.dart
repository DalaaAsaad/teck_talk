import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/code_section.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/content_input.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/image_section.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/profile_section.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/published_button.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/top_bar.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/topices_section.dart';

class CreatePost extends GetView<CreatePostController> {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.045),
            vertical: Responsive.hp(0.014),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              SizedBox(height: Responsive.hp(0.02)),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(Responsive.wp(0.04)),
                decoration: BoxDecoration(
                  color: Appcolor.panel,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Appcolor.panelEdge),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileSection(),
                    SizedBox(height: Responsive.hp(0.018)),
                    Container(height: 1, color: Appcolor.panelEdge),
                    SizedBox(height: Responsive.hp(0.016)),
                    const ContentInput(),
                  ],
                ),
              ),

              SizedBox(height: Responsive.hp(0.02)),
              const ImageSection(),
              SizedBox(height: Responsive.hp(0.02)),
              const CodeSection(),
              SizedBox(height: Responsive.hp(0.02)),
              const TopicesSection(),
              SizedBox(height: Responsive.hp(0.03)),
              PublishDraftButtonWidget(
                onDraft: controller.createDraft,
                onPublish: controller.creatPost,
                selectedIndex: controller.selectedIndex,
                onSelected: controller.selectButton,
              ),
              SizedBox(height: Responsive.hp(0.08)),
            ],
          ),
        ),
      ),
    );
  }
}
