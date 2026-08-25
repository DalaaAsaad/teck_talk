import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/custom_widget/upload_image_container.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/create_post_controller.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/elevated_card.dart';

class ImageSection extends GetView<CreatePostController> {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      title: "Images",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Click to upload images",
            styleType: TextStyleType.BODY,
            textColor: Appcolor.muted,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: Responsive.hp(0.014)),
          UploadImageContainer(
            images: controller.selectedImages,
            text: "Click to add images",
          ),
        ],
      ),
    );
  }
}