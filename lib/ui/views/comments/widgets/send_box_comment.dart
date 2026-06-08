import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/comments_controller.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/views/code_view/code_view.dart';

class SendBoxComment extends GetView<CommentsController> {
  const SendBoxComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(40),
        vertical: screenWidth(50),
      ),
      color: Appcolor.black_08,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: screenWidth(7),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(40),
                vertical: screenWidth(200),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Appcolor.yellow_70, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.typeController,
                      style: TextStyle(color: Appcolor.white),
                      decoration: InputDecoration(
                        hintText: "Type a comment",
                        hintStyle: TextStyle(
                          color: Appcolor.white.withAlpha(150),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          child: CodeView(
                            mode: CodeViewMode.input,
                            code: "",
                            isdialog: true,
                            controller: controller.codeController,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      color: Appcolor.yellow_70,
                      size: screenWidth(12),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: screenWidth(40)),

          GestureDetector(
            onTap: () {
              controller.commentPost();
            },
            child: Icon(
              Icons.send,
              color: Appcolor.yellow_70,
              size: screenWidth(12),
            ),
          ),
        ],
      ),
    );
  }
}
