import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github-gist.dart';
import 'package:teck_talk/ui/views/code_view/code_header.dart';
import 'package:teck_talk/ui/views/code_view/code_model.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class CodeView extends StatefulWidget {
  final String? code;
  final String? languageCode;
  final CodeViewMode mode;
  final bool isdialog;

  const CodeView({
    super.key,
    required this.code,
    required this.mode,
    this.isdialog = false,
    this.languageCode,
  });

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Appcolor.Black_05,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CodeHeader(
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
          ),
          Divider(color: Appcolor.yellow_70),

          if (isExpanded && widget.mode == CodeViewMode.view)
            Container(
              width: double.infinity,
              height: widget.isdialog ? screenWidth(0.8) : screenWidth(2),
              padding: EdgeInsets.all(screenWidth(100)),
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
                    padding: EdgeInsets.all(screenWidth(30)),
                    textStyle: TextStyle(fontFamily: 'monospace', fontSize: 14),
                  ),
                ),
              ),
            ),
          if (widget.mode == CodeViewMode.input)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth(100)),
              decoration: BoxDecoration(
                color: Appcolor.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                maxLines: 15,
                minLines: 3,
                style: TextStyle(color: Appcolor.black_08),
                decoration: InputDecoration(
                  hintText: "Type a code",
                  hintStyle: TextStyle(color: Appcolor.black_08.withAlpha(150)),
                  border: InputBorder.none,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
