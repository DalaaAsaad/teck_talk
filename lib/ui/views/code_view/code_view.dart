import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github-gist.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/views/code_view/code_header.dart';
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class CodeView extends StatefulWidget {
  final String? code;
  final String? languageCode;
  final CodeViewMode mode;
  final bool isdialog;
  final TextEditingController? controller;
  final bool isCommentCode;
  final bool? isSafe;

  const CodeView({
    super.key,
    required this.code,
    required this.mode,
    this.isdialog = false,
    this.languageCode,
    this.controller,
    this.isCommentCode = false,
    this.isSafe,
  });

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final showSafetyBadge = widget.isCommentCode && widget.isSafe != null;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.025),
        vertical: Responsive.hp(0.012),
      ),
      decoration: BoxDecoration(
        color: Appcolor.panelEdge,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Appcolor.panelEdge.withAlpha(120)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CodeHeader(
                  mode: widget.mode,
                  isDialog: widget.isdialog,
                  isExpanded: isExpanded,
                  onToggle: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  onCopy: () {
                    if (widget.code != null) {
                      Clipboard.setData(ClipboardData(text: widget.code!));
                    }
                  },
                  onSave: () {
                    final code = widget.controller?.text.trim();

                    if (code != null && code.isNotEmpty) {
                      Get.back(result: code);
                    }
                  },
                  onClose: () {
                    widget.controller?.clear();

                    Get.back();
                  },
                ),
              ),
              if (showSafetyBadge) ...[
                SizedBox(width: Responsive.wp(0.02)),
                _SafetyBadge(isSafe: widget.isSafe!),
              ],
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.006)),
            child: Divider(height: 1, color: Appcolor.accent.withAlpha(90)),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: !isExpanded
                ? const SizedBox(width: double.infinity)
                : Column(
                    children: [
                      if (widget.mode == CodeViewMode.view)
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: widget.isdialog
                                ? Responsive.hp(0.55)
                                : Responsive.hp(0.35),
                          ),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: Responsive.hp(0.01)),
                            padding: EdgeInsets.all(Responsive.wp(0.05)),
                            decoration: BoxDecoration(
                              color: Appcolor.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: HighlightView(
                                  widget.code ?? "",
                                  language: widget.languageCode ?? "",
                                  theme: githubGistTheme,
                                  textStyle: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: Responsive.sp(0.04),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (widget.mode == CodeViewMode.input)
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: Responsive.hp(0.01)),
                          padding: EdgeInsets.all(Responsive.wp(0.05)),
                          decoration: BoxDecoration(
                            color: Appcolor.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: widget.controller,
                            maxLines: 15,
                            minLines: 3,
                            cursorColor: Appcolor.accent,
                            style: TextStyle(
                              color: Appcolor.panelEdge,
                              fontFamily: 'monospace',
                              fontSize: Responsive.sp(0.04),
                            ),
                            decoration: InputDecoration(
                              hintText: "Type a code",
                              hintStyle: TextStyle(
                                color: Appcolor.panelEdge.withAlpha(150),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _SafetyBadge extends StatelessWidget {
  final bool isSafe;

  const _SafetyBadge({required this.isSafe});

  @override
  Widget build(BuildContext context) {
    final Color color = isSafe
        ? const Color(0xFF3EC98A)
        : const Color(0xFFE05C5C);
    // final String label = isSafe ? "Safe" : "Unsafe";
    final IconData icon = isSafe
        ? Icons.verified_rounded
        : Icons.warning_amber_rounded;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.022),
        vertical: Responsive.hp(0.006),
      ),
      // decoration: BoxDecoration(
      //   color: color.withOpacity(0.14),
      //   borderRadius: BorderRadius.circular(999),
      //   border: Border.all(color: color.withOpacity(0.4)),
      // ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Responsive.sp(0.05), color: color),
          // SizedBox(width: Responsive.wp(0.01)),
          // Text(
          //   label,
          //   style: TextStyle(
          //     color: color,
          //     fontSize: Responsive.sp(0.032),
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
        ],
      ),
    );
  }
}
