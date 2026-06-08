import 'package:flutter/material.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
import 'package:tech_talk/ui/views/activity_user/widget/activity_header.dart';
import 'package:tech_talk/ui/views/activity_user/widget/activity_tabs.dart';

class ActivityUser extends StatelessWidget {
  const ActivityUser({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Appcolor.black_08,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActivityHeader(),
                    SizedBox(height: screenWidth(10)),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'One place to manage\n        your activity',
                            styleType: TextStyleType.TITLE,
                            textColor: Appcolor.white,
                            fontSize: screenWidth(13),
                            fontWeight: FontWeight.w800,
                          ),
                          SizedBox(height: screenWidth(30)),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: screenWidth(5),
                              end: screenWidth(5),
                            ),
                            child: CustomText(
                              text:
                                  'View and manage your interactions, content and account activity.',
                              styleType: TextStyleType.CUSTOM,
                              textColor: Appcolor.gray_60,
                              fontSize: screenWidth(30),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth(16)),
                    const ActivityTabs(),
                    SizedBox(height: screenWidth(22)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
