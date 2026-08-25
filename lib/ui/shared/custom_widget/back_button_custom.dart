import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Get.back() ,
        borderRadius: BorderRadius.circular(12),
        child: Container(
           child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey.shade500,
            size: Responsive.sp(0.05),
          ),
        ),
      ),
    );
  }
}
