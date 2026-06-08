import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/custom_widget/upload_image_container.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/ui/views/main_view/create_post/widgets/section_header.dart';

class ImageSection extends GetView<CreatePostController> {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Images"),
        SizedBox(height: screenWidth(30)),
        CustomText(
          text: "click to upload images",
          styleType: TextStyleType.BODY,
          textColor: Appcolor.gray_60,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: screenWidth(40)),
        UploadImageContainer(
          images: controller.selectedImages,
          text: "Click to add images",
        ),
      ],
    );
  }
}
