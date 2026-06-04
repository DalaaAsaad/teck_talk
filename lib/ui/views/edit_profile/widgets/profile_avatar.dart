import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({required this.onEditTap, this.imagePath, super.key});

  final VoidCallback onEditTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final ImageProvider avatarImage = imagePath != null && imagePath!.isNotEmpty
        ? FileImage(File(imagePath!))
        : const AssetImage('assets/images/png/profile.png');

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: screenWidth(4),
            height: screenWidth(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Appcolor.dark_20),
              image: DecorationImage(image: avatarImage, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            right: screenWidth(-200),
            bottom: screenWidth(-200),
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                width: screenWidth(13),
                height: screenWidth(13),
                decoration: BoxDecoration(
                  color: Appcolor.yellow_70,
                  shape: BoxShape.circle,
                  border: Border.all(color: Appcolor.black_08, width: 2),
                ),
                child: Icon(
                  Icons.edit,
                  color: Appcolor.black_08,
                  size: screenWidth(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
