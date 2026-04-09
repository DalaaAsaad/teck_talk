import 'package:flutter/material.dart';

import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';
import 'package:teck_talk/ui/views/code_view/code_view.dart';

class CodeDialog extends StatelessWidget {
  final CodeView codeView;

  const CodeDialog({super.key, required this.codeView});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Appcolor.Black_05,
      insetPadding: EdgeInsets.all(screenWidth(30)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: codeView,
    );
  }
}
