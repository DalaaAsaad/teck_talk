import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/responses/suggestions_folowed_response.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/views/code_view/code_view.dart';

class SendBoxComment extends StatelessWidget {
  final VoidCallback onSend;
  final TextEditingController typeController;
  final TextEditingController codeController;

  final RxList<SuggestedUser> mentionUsers;
  final RxBool showMentionList;
  final Function(SuggestedUser) onMentionTap;

  const SendBoxComment({
    super.key,
    required this.onSend,
    required this.typeController,
    required this.codeController,
    required this.mentionUsers,
    required this.showMentionList,
    required this.onMentionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.02),
        vertical: Responsive.hp(0.01),
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMentionList.value && mentionUsers.isNotEmpty)
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: Responsive.hp(0.25)),
                margin: EdgeInsets.only(bottom: Responsive.hp(0.01)),
                decoration: BoxDecoration(
                  color: Appcolor.dark_20,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Appcolor.accent, width: 1),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mentionUsers.length,
                  itemBuilder: (context, index) {
                    final user = mentionUsers[index];

                    return ListTile(
                      onTap: () => onMentionTap(user),
                      leading: CircleAvatar(
                        backgroundColor: Appcolor.accentGradientStart,
                        backgroundImage: user.avatar != null
                            ? NetworkImage(user.avatar!)
                            : null,
                        child: user.avatar == null
                            ? const Icon(Icons.person, color: Appcolor.accent)
                            : null,
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(color: Appcolor.white),
                      ),
                      subtitle: Text(
                        '@${user.username}',
                        style: TextStyle(color: Appcolor.white.withAlpha(150)),
                      ),
                    );
                  },
                ),
              ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: Responsive.hp(0.07),
                    padding: EdgeInsetsDirectional.only(
                      start: Responsive.wp(0.04),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Appcolor.accent, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: typeController,
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
                                  controller: codeController,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add,
                            color: Appcolor.accent,
                            size: Responsive.sp(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: Responsive.wp(0.02)),

                GestureDetector(
                  onTap: onSend,
                  child: Icon(
                    Icons.send,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.09),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
