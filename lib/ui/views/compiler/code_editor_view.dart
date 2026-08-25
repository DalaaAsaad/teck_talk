import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/compiler_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/compiler/widgets/console_tab_button.dart';
import 'package:tech_talk/ui/views/compiler/widgets/icon_action.dart';
import 'package:tech_talk/ui/views/compiler/widgets/input_panel.dart';
import 'package:tech_talk/ui/views/compiler/widgets/lang_avatar.dart';
import 'package:tech_talk/ui/views/compiler/widgets/line_numbers.dart';
import 'package:tech_talk/ui/views/compiler/widgets/output_panel.dart';

class CodeEditorView extends StatefulWidget {
  const CodeEditorView({super.key});

  @override
  State<CodeEditorView> createState() => _CodeEditorViewState();
}

class _CodeEditorViewState extends State<CodeEditorView> {
  late final CompilerController controller;
  late final Worker _messageWorker;

  double get _consolePanelHeight => Responsive.hp(0.20);

  @override
  void initState() {
    super.initState();

    controller = Get.isRegistered<CompilerController>()
        ? Get.find<CompilerController>()
        : Get.put(CompilerController());

    _messageWorker = ever<CompilerUiMessage?>(controller.uiMessage, (msg) {
      if (msg == null) return;
      _showSnack(msg.text, isError: msg.isError);
    });
  }

  @override
  void dispose() {
    _messageWorker.dispose();
    super.dispose();
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(fontSize: Responsive.sp(0.04))),
        backgroundColor: isError ? Appcolor.danger : Appcolor.panel,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.all(Responsive.wp(0.04)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Responsive.wp(0.04)),
        ),
      ),
    );
  }

  Future<void> _pickLanguage() async {
    final picked = await showModalBottomSheet<LanguageOption>(
      context: context,
      backgroundColor: Appcolor.panel,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Responsive.wp(0.06)),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.01)),
                  child: Container(
                    width: Responsive.wp(0.12),
                    height: Responsive.hp(0.006),
                    decoration: BoxDecoration(
                      color: Appcolor.panelEdge,
                      borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.wp(0.05),
                    vertical: Responsive.hp(0.01),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose a programming language',
                      style: TextStyle(
                        color: Appcolor.white,
                        fontSize: Responsive.sp(0.045),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: Responsive.hp(0.60)),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.wp(0.04),
                      vertical: Responsive.hp(0.01),
                    ),
                    itemCount: controller.languages.length,
                    separatorBuilder: (_, __) {
                      return SizedBox(height: Responsive.hp(0.008));
                    },
                    itemBuilder: (_, i) {
                      final lang = controller.languages[i];
                      final selected =
                          lang.apiValue ==
                          controller.selectedLanguage.value?.apiValue;

                      return GestureDetector(
                        onTap: () => Navigator.pop(ctx, lang),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.wp(0.04),
                            vertical: Responsive.hp(0.014),
                          ),
                          decoration: BoxDecoration(
                            color: selected ? Appcolor.accentDim : Appcolor.bg,
                            borderRadius: BorderRadius.circular(
                              Responsive.wp(0.04),
                            ),
                            border: Border.all(
                              color: selected
                                  ? Appcolor.accent
                                  : Appcolor.panelEdge,
                              width: Responsive.wp(0.003),
                            ),
                          ),
                          child: Row(
                            children: [
                              LangAvatar(
                                label: lang.short,
                                selected: selected,
                                size: Responsive.wp(0.10),
                              ),
                              SizedBox(width: Responsive.wp(0.03)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang.name,
                                      style: TextStyle(
                                        color: selected
                                            ? Appcolor.accent
                                            : Appcolor.white,
                                        fontSize: Responsive.sp(0.04),
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                      ),
                                    ),
                                    if (lang.version != null)
                                      Text(
                                        lang.version!,
                                        style: TextStyle(
                                          color: Appcolor.muted,
                                          fontSize: Responsive.sp(0.03),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (selected)
                                Icon(
                                  Icons.check_circle,
                                  color: Appcolor.accent,
                                  size: Responsive.sp(0.045),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Responsive.hp(0.02)),
              ],
            ),
          ),
        );
      },
    );

    if (picked != null) {
      controller.selectLanguage(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ============ Top bar ============
        Padding(
          padding: EdgeInsets.fromLTRB(
            Responsive.wp(0.04),
            Responsive.hp(0.01),
            Responsive.wp(0.04),
            Responsive.hp(0.01),
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(() {
                  final lang = controller.selectedLanguage.value;
                  return GestureDetector(
                    onTap: _pickLanguage,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.wp(0.03),
                        vertical: Responsive.hp(0.012),
                      ),
                      decoration: BoxDecoration(
                        color: Appcolor.panel,
                        borderRadius: BorderRadius.circular(
                          Responsive.wp(0.035),
                        ),
                        border: Border.all(
                          color: lang == null
                              ? Appcolor.panelEdge
                              : Appcolor.accent,
                          width: Responsive.wp(0.003),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (lang != null) ...[
                            LangAvatar(
                              label: lang.short,
                              selected: true,
                              size: Responsive.wp(0.075),
                            ),
                            SizedBox(width: Responsive.wp(0.02)),
                          ] else ...[
                            Icon(
                              Icons.developer_mode,
                              size: Responsive.sp(0.05),
                              color: Appcolor.accent,
                            ),
                            SizedBox(width: Responsive.wp(0.02)),
                          ],
                          Expanded(
                            child: Text(
                              lang?.name ?? 'Select language',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: lang == null
                                    ? Appcolor.muted
                                    : Appcolor.white,
                                fontSize: Responsive.sp(0.04),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: Responsive.sp(0.05),
                            color: Appcolor.muted,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(width: Responsive.wp(0.015)),
              IconAction(icon: Icons.copy_rounded, onTap: controller.copyCode),
              SizedBox(width: Responsive.wp(0.015)),
              IconAction(
                icon: Icons.delete_outline_rounded,
                onTap: controller.clearCode,
              ),
              SizedBox(width: Responsive.wp(0.015)),
              // Only this button depends on isLoading.
              Obx(() {
                final loading = controller.isLoading.value;
                return GestureDetector(
                  onTap: loading ? null : controller.runCode,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.wp(0.035),
                      vertical: Responsive.hp(0.012),
                    ),
                    decoration: BoxDecoration(
                      color: loading
                          ? Appcolor.accent.withOpacity(0.6)
                          : Appcolor.accent,
                      borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (loading)
                          SizedBox(
                            width: Responsive.wp(0.045),
                            height: Responsive.wp(0.045),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        else
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: Responsive.sp(0.05),
                          ),
                        SizedBox(width: Responsive.wp(0.01)),
                        Text(
                          'Run',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.sp(0.038),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Responsive.wp(0.04)),
            decoration: BoxDecoration(
              color: Appcolor.panel,
              borderRadius: BorderRadius.circular(Responsive.wp(0.04)),
              border: Border.all(
                color: Appcolor.panelEdge,
                width: Responsive.wp(0.003),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LineNumbers(controller: controller.codeController),
                Expanded(
                  child: TextField(
                    controller: controller.codeController,
                    focusNode: controller.codeFocusNode,
                    maxLines: null,
                    expands: true,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: Responsive.sp(0.04),
                      fontFamily: 'monospace',
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Responsive.hp(0.015),
                        horizontal: Responsive.wp(0.03),
                      ),
                      hintText: '// Write your code here...',
                      hintStyle: TextStyle(
                        color: Appcolor.muted,
                        fontSize: Responsive.sp(0.04),
                      ),
                    ),
                    // Rebuilds only this State (for the line-number
                    // gutter) — does not touch the console/Obx below.
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: Responsive.hp(0.015)),

        Obx(() {
          if (controller.codeFocused.value) {
            return const SizedBox(width: double.infinity);
          }

          return Container(
            decoration: BoxDecoration(
              color: Appcolor.panel,
              border: Border(
                top: BorderSide(
                  color: Appcolor.panelEdge,
                  width: Responsive.wp(0.002),
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      ConsoleTabButton(
                        label: 'Input',
                        icon: Icons.keyboard_alt_outlined,
                        active: controller.consoleTab.value == 'input',
                        onTap: () => controller.setConsoleTab('input'),
                      ),
                      ConsoleTabButton(
                        label: 'Output',
                        icon: Icons.terminal,
                        active: controller.consoleTab.value == 'output',
                        dotColor: controller.errorMessage.value.isNotEmpty
                            ? Appcolor.danger
                            : null,
                        onTap: () => controller.setConsoleTab('output'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Responsive.wp(0.04),
                      Responsive.hp(0.012),
                      Responsive.wp(0.04),
                      Responsive.hp(0.015),
                    ),
                    child: controller.consoleTab.value == 'input'
                        ? InputPanel(
                            inputController: controller.inputController,
                            height: _consolePanelHeight,
                          )
                        : OutputPanel(
                            isLoading: controller.isLoading.value,
                            error: controller.errorMessage.value,
                            output: controller.output.value,
                            height: _consolePanelHeight,
                            onCopy: controller.output.value.isEmpty
                                ? null
                                : controller.copyOutput,
                          ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
