import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/controllers/blog_controller.dart';
import 'package:teck_talk/ui/views/main_view/blog/blog_card.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class blog extends GetView<BlogController> {
  const blog({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolor.black_08,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Appcolor.yellow_70),
          );
        }

        if (controller.blogs.isEmpty) {
          return Center(
            child: Text(
              'No blogs found',
              style: TextStyle(color: Appcolor.white),
            ),
          );
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.blogs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: BlogCard(blog: controller.blogs[index]),
                );
              },
            ),
            SizedBox(height: screenWidth(5)),
          ],
        );
      }),
    );
  }
}
