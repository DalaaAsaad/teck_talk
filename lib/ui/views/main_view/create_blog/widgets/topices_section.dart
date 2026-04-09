import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/create_blog_controller.dart';
import 'package:teck_talk/ui/views/main_view/create_blog/widgets/section_header.dart';

class TopicesSection extends GetView<CreateBlogController> {
  const TopicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          SectionHeader(title: "Topics"),
          SizedBox(height: screenWidth(68)),

          CustomText(
            text: "Add topics (e.g., React, JavaScript)",
            styleType: TextStyleType.BODY,
            textColor: Appcolor.gray_60,
          ),
          SizedBox(height: screenWidth(40)),

          // Chips row + plus button
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Selected topic chips
              ...controller.selectedTopics.map(
                (topic) => Chip(
                  backgroundColor: Appcolor.yellow_70,

                  label: CustomText(
                    text: topic,
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.black_08,
                  ),
                  deleteIcon: Icon(
                    Icons.close,
                    size: screenWidth(20),
                    color: Appcolor.black_08,
                  ),
                  onDeleted: () => controller.toggleTopic(topic),
                ),
              ),

              // Plus button
              Builder(
                builder: (btnContext) => GestureDetector(
                  onTap: () => controller.showTopicsDialog(btnContext),
                  child: Container(
                    child: Icon(
                      Icons.add,
                      color: Appcolor.yellow_70,
                      size: screenWidth(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
