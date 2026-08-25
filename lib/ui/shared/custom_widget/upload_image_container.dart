import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/app_image_picker.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';

class UploadImageContainer extends StatelessWidget {
  final List<XFile> images;
  final String text;

  const UploadImageContainer({
    super.key,
    required this.images,
    required this.text,
  });

  Future<void> _pickImages() async {
    final picked = await AppImagePicker.instance.pickMultiImage();
    if (picked.isNotEmpty) {
      images.addAll(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: Responsive.hp(0.28),
        decoration: BoxDecoration(
          border: Border.all(color: Appcolor.muted),
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: images.isEmpty
            ? _buildEmptyState()
            : Padding(
                padding: EdgeInsets.all(Responsive.wp(0.02)),
                child: _buildImagesPageView(images),
              ),
      );
    });
  }

  Widget _buildEmptyState() {
    return GestureDetector(
      onTap: _pickImages,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, color: Appcolor.accent, size: Responsive.sp(0.07)),
          SizedBox(height: Responsive.hp(0.01)),
          CustomText(
            text: text,
            styleType: TextStyleType.BODY,
            textColor: Appcolor.muted,
          ),
        ],
      ),
    );
  }

  Widget _buildImagesPageView(List<XFile> images) {
    return PageView.builder(
      itemCount: images.length + 1,
      itemBuilder: (context, index) {
        if (index == images.length) {
          return _buildAddMore();
        }

        return _buildImageItem(images[index], index);
      },
    );
  }

  Widget _buildAddMore() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Responsive.wp(0.01)),
        decoration: BoxDecoration(
          border: Border.all(color: Appcolor.muted),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Appcolor.white, size: Responsive.sp(0.07)),
            SizedBox(height: Responsive.hp(0.01)),
            CustomText(
              text: "Add more",
              styleType: TextStyleType.SMALL,
              textColor: Appcolor.muted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(XFile image, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.wp(0.01)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(File(image.path), fit: BoxFit.cover),
          ),

          Positioned(
            top: Responsive.wp(0.02),
            right: Responsive.wp(0.02),
            child: GestureDetector(
              onTap: () => removeImage(index, images),
              child: Container(
                padding: EdgeInsets.all(Responsive.wp(0.015)),
                decoration: BoxDecoration(
                  color: Appcolor.black_08,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: Responsive.sp(0.045),
                  color: Appcolor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}