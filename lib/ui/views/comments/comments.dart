import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teck_talk/ui/views/code_view/code_model.dart';
import 'package:teck_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:teck_talk/ui/views/code_view/code_view.dart';
import 'package:teck_talk/ui/shared/custom_widget/comment_card.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/comments/comments_controller.dart';

class Comments extends StatelessWidget {
  CommentsController controller = Get.put(CommentsController());
  String? code = """void main (){
    print("hello world");
    }""";
  Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: screenWidth(15),
                start: screenWidth(20),
                end: screenWidth(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    children: [
                      CustomText(
                        text: "150 ",
                        styleType: TextStyleType.BODY,
                        textColor: Appcolor.white.withAlpha(150),
                      ),
                      CustomText(
                        text: "   Comments",
                        styleType: TextStyleType.BODY,
                        textColor: Appcolor.white.withAlpha(150),
                      ),
                    ],
                  ),

                  ActiveIcon(
                    icon: Icon(Icons.favorite_border),
                    iconIsActive: Icon(Icons.favorite),
                    numOfInteractors: "200 k",
                    color: Appcolor.red,
                    isActive: controller.isFavorite,
                    function: controller.toggleFavorit,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: screenWidth(100)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        controller: controller,
                        code: code,
                        numFavorite: "200",
                        numLikes: '0',
                        numDislikes: '0',
                        history: '7 days',
                        imagePath: "assets/images/png/profile.png",
                        textcomment:
                            "Try adding a dependency array in useEffect That usually fixes the infinite loop issue",
                        nameProfile: 'Ahmad Hassan',
                        numComments: "200 k",
                      );
                    },
                  ),
                ],
              ),
            ),

            Container(
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
                                    code: code,
                                    isdialog: true,
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
                    onTap: () {},
                    child: Icon(
                      Icons.send,
                      color: Appcolor.yellow_70,
                      size: screenWidth(12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
