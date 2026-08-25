import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/compiler/compiler.dart';
import 'package:tech_talk/ui/views/uml_view/uml_view.dart';

const String _kLastUsedToolKey = 'last_used_tool_id';

enum ToolId { uml, chatbot, compiler, roadmap }

class ToolMeta {
  final ToolId id;
  final String label;
  final String subtitle;
  final Widget Function() iconBuilder;
  final VoidCallback navigate;

  const ToolMeta({
    required this.id,
    required this.label,
    required this.subtitle,
    required this.iconBuilder,
    required this.navigate,
  });
}

List<ToolMeta> _buildTools() => [
  ToolMeta(
    id: ToolId.uml,
    label: 'UML Diagrams',
    subtitle: 'Design class & sequence diagrams',
    iconBuilder: () => SvgPicture.asset(
      'assets/images/svg/umlIcon.svg',
      color: Appcolor.accent,
      height: Responsive.hp(0.024),
      width: Responsive.hp(0.024),
    ),
    navigate: () => Get.to(() => UmlView()),
  ),
  ToolMeta(
    id: ToolId.chatbot,
    label: 'AI ChatBot',
    subtitle: 'Ask questions, get instant help',
    iconBuilder: () => Icon(
      Icons.smart_toy_rounded,
      color: Appcolor.accent,
      size: Responsive.sp(0.05),
    ),
    navigate: () => Get.toNamed(AppRoutes.chatbot),
  ),
  ToolMeta(
    id: ToolId.compiler,
    label: 'Compiler',
    subtitle: 'Write & run code snippets',
    iconBuilder: () => SvgPicture.asset(
      'assets/images/svg/compilerIcon.svg',
      color: Appcolor.accent,
      height: Responsive.hp(0.024),
      width: Responsive.hp(0.024),
    ),
    navigate: () => Get.to(() => Compiler()),
  ),
  ToolMeta(
    id: ToolId.roadmap,
    label: 'Roadmap',
    subtitle: 'Follow a guided learning path',
    iconBuilder: () => SvgPicture.asset(
      'assets/images/svg/roadmapIcon.svg',
      color: Appcolor.accent,
      height: Responsive.hp(0.024),
      width: Responsive.hp(0.024),
    ),
    navigate: () => Get.toNamed(AppRoutes.roadmaps),
  ),
];

Future<void> _saveLastUsedTool(ToolId id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLastUsedToolKey, id.name);
}

Future<ToolMeta?> getLastUsedTool() async {
  final prefs = await SharedPreferences.getInstance();
  final savedId = prefs.getString(_kLastUsedToolKey);
  if (savedId == null) return null;

  final tools = _buildTools();
  for (final tool in tools) {
    if (tool.id.name == savedId) return tool;
  }
  return null;
}

class ToolsMenuButton extends StatelessWidget {
  const ToolsMenuButton({super.key, this.onToolUsed});

  final VoidCallback? onToolUsed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openToolsSheet(context),
        borderRadius: BorderRadius.circular(Responsive.wp(0.05)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.03),
            vertical: Responsive.wp(0.018),
          ),
          decoration: BoxDecoration(
            color: Appcolor.panel,
            borderRadius: BorderRadius.circular(Responsive.wp(0.05)),
            border: Border.all(
              color: Appcolor.panelEdge,
              width: Responsive.wp(0.0025),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.apps_rounded,
                color: Appcolor.accent,
                size: Responsive.sp(0.038),
              ),
              SizedBox(width: Responsive.wp(0.015)),
              CustomText(
                text: 'Tools',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.032),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openToolsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _ToolsSheet(onToolUsed: onToolUsed),
    );
  }
}

class LastUsedToolShortcut extends StatelessWidget {
  const LastUsedToolShortcut({
    super.key,
    required this.tool,
    required this.onTap,
  });

  final ToolMeta tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tool.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Responsive.wp(0.05)),
          child: Container(
            width: Responsive.wp(0.1),
            height: Responsive.wp(0.1),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Appcolor.accentDim,
              shape: BoxShape.circle,
              border: Border.all(
                color: Appcolor.accent.withOpacity(0.4),
                width: Responsive.wp(0.0025),
              ),
            ),
            child: tool.iconBuilder(),
          ),
        ),
      ),
    );
  }
}

class _ToolsSheet extends StatelessWidget {
  const _ToolsSheet({this.onToolUsed});

  final VoidCallback? onToolUsed;

  @override
  Widget build(BuildContext context) {
    final tools = _buildTools();

    return Container(
      padding: EdgeInsets.fromLTRB(
        Responsive.wp(0.05),
        Responsive.hp(0.015),
        Responsive.wp(0.05),
        Responsive.hp(0.035),
      ),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Responsive.wp(0.06)),
        ),
        border: Border(
          top: BorderSide(color: Appcolor.panelEdge, width: 1),
          left: BorderSide(color: Appcolor.panelEdge, width: 0.5),
          right: BorderSide(color: Appcolor.panelEdge, width: 0.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: Responsive.wp(0.1),
              height: Responsive.hp(0.005),
              margin: EdgeInsets.only(bottom: Responsive.hp(0.018)),
              decoration: BoxDecoration(
                color: Appcolor.panelEdge,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          CustomText(
            text: 'Tools',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.048),
            fontWeight: FontWeight.w700,
          ),

          SizedBox(height: Responsive.hp(0.02)),

          for (final tool in tools)
            _ToolTile(
              tool: tool,
              onTap: () async {
                Get.back();
                await _saveLastUsedTool(tool.id);
                onToolUsed?.call();
                tool.navigate();
              },
            ),
        ],
      ),
    );
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({required this.tool, required this.onTap});

  final ToolMeta tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.012)),
          child: Row(
            children: [
              Container(
                width: Responsive.wp(0.12),
                height: Responsive.wp(0.12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Appcolor.accentDim,
                  borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
                ),
                child: tool.iconBuilder(),
              ),
              SizedBox(width: Responsive.wp(0.035)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: tool.label,
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.white,
                      fontSize: Responsive.sp(0.038),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: Responsive.hp(0.002)),
                    CustomText(
                      text: tool.subtitle,
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.muted,
                      fontSize: Responsive.sp(0.03),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Appcolor.muted,
                size: Responsive.sp(0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
