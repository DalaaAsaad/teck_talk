import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';

import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/code_view/code_view.dart';

class CodeDialog extends StatelessWidget {
  final CodeView codeView;

  const CodeDialog({super.key, required this.codeView});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,

      insetPadding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.03),
        vertical: Responsive.hp(0.05),
      ),

      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: Responsive.hp(0.8)),
        child: codeView,
      ),
    );
  }
}
