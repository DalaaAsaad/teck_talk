import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/controllers/homecontroller.dart';
import 'package:tech_talk/ui/views/main_view/home/widgets/list_posts_body.dart';
import 'package:tech_talk/ui/views/main_view/home/widgets/tool_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Homecontroller controller = Get.find();

  ToolMeta? _lastUsedTool;

  @override
  void initState() {
    super.initState();
    _loadLastUsedTool();
  }

  Future<void> _loadLastUsedTool() async {
    final tool = await getLastUsedTool();
    if (mounted) {
      setState(() => _lastUsedTool = tool);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Appcolor.bg),
            Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: Responsive.wp(0.045),
                    top: Responsive.hp(0.015),
                    end: Responsive.wp(0.045),
                    bottom: Responsive.hp(0.01),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Home',
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.white,
                        fontSize: Responsive.sp(0.05),
                        fontWeight: FontWeight.w700,
                      ),

                      Row(
                        children: [
                          if (_lastUsedTool != null) ...[
                            LastUsedToolShortcut(
                              tool: _lastUsedTool!,
                              onTap: _lastUsedTool!.navigate,
                            ),
                            SizedBox(width: Responsive.wp(0.02)),
                          ],
                          ToolsMenuButton(onToolUsed: _loadLastUsedTool),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: ListPostsBody()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
