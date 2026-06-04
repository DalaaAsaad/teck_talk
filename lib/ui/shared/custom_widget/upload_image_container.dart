import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class UploadImageContainer extends StatelessWidget {
  final List<XFile> images;
  final String text;

  const UploadImageContainer({
    super.key,
    required this.images,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        constraints: BoxConstraints(
          minHeight: screenWidth(3),
          maxHeight: screenWidth(1.6),
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Appcolor.gray_60),
          borderRadius: BorderRadius.circular(10),
        ),
        child: images.isEmpty
            ? _buildEmptyState()
            : Padding(
                padding: EdgeInsetsDirectional.all(screenWidth(68)),
                child: _buildImagesGrid(images),
              ),
      );
    });
  }

  // 🔹 Empty UI
  Widget _buildEmptyState() {
    return GestureDetector(
      onTap: () => pickImages(images),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, color: Appcolor.yellow_70, size: screenWidth(13)),
          SizedBox(height: screenWidth(51)),
          CustomText(
            text: text,
            styleType: TextStyleType.BODY,
            textColor: Appcolor.gray_60,
          ),
        ],
      ),
    );
  }

  // 🔹 PageView بدل Grid
  Widget _buildImagesGrid(List<XFile> images) {
    return SizedBox(
      height: screenWidth(1.6),
      child: PageView.builder(
        itemCount: images.length + 1,
        itemBuilder: (context, index) {
          if (index == images.length) {
            return GestureDetector(
              onTap: () => pickImages(images),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth(102)),
                decoration: BoxDecoration(
                  border: Border.all(color: Appcolor.gray_60),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Appcolor.white,
                      size: screenWidth(10),
                    ),
                    SizedBox(height: screenWidth(51)),
                    CustomText(
                      text: "Add more",
                      styleType: TextStyleType.SMALL,
                      textColor: Appcolor.gray_60,
                    ),
                  ],
                ),
              ),
            );
          }

          return _buildImageItem(images[index], index);
        },
      ),
    );
  }

  Widget _buildImageItem(XFile image, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth(102)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(image.path),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            top: screenWidth(40),
            right: screenWidth(40),
            child: GestureDetector(
              onTap: () => removeImage(index, images),
              child: Container(
                padding: EdgeInsetsDirectional.all(screenWidth(68)),
                decoration: BoxDecoration(
                  color: Appcolor.black_08,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: screenWidth(25),
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
