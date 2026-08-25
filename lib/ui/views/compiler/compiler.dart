import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/compiler_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/back_button_custom.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/compiler/widgets/title_compiler.dart';



class Compiler extends StatelessWidget {
  const Compiler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      appBar: AppBar(
        backgroundColor: Appcolor.bg,
        elevation: 0,
        leading: const BackButtonCustom(),
        title: const TitleCompiler(),
      ),
      body: const SafeArea(child: CodeEditorView()),
    );
  }
}

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

    // Reuse the existing controller instance if one is already registered
    // (e.g. after a hot reload / parent rebuild) instead of creating a
    // fresh one and silently discarding typed code / re-wiring focus nodes.
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
                    // Plain list — selection highlight isn't needed live
                    // while the sheet is open, so no Obx/reactivity here.
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
                              _LangAvatar(
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
              // Only this chip depends on selectedLanguage — scope the Obx
              // to just this widget, not the whole screen.
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
                            _LangAvatar(
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
              _IconAction(
                icon: Icons.copy_rounded,
                onTap: controller.copyCode,
              ),
              SizedBox(width: Responsive.wp(0.015)),
              _IconAction(
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

        // ============ Code editor ============
        // Deliberately NOT wrapped in Obx. It never needs to rebuild in
        // response to Rx changes elsewhere, and keeping it outside any
        // reactive scope means it's never torn down/rebuilt while it has
        // focus or is mid-composition — that coupling was the root cause
        // of the freeze/crash.
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
                _LineNumbers(controller: controller.codeController),
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

        // ============ Bottom console (Input / Output) ============
        // Everything this needs (codeFocused, consoleTab, errorMessage,
        // output, isLoading) is reactive, so it gets its own Obx — scoped
        // away from the code editor above.
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
                      _ConsoleTabButton(
                        label: 'Input',
                        icon: Icons.keyboard_alt_outlined,
                        active: controller.consoleTab.value == 'input',
                        onTap: () => controller.setConsoleTab('input'),
                      ),
                      _ConsoleTabButton(
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
                        ? _InputPanel(
                            inputController: controller.inputController,
                            height: _consolePanelHeight,
                          )
                        : _OutputPanel(
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

// ============ Presentational widgets (no logic) ============

class _ConsoleTabButton extends StatelessWidget {
  const _ConsoleTabButton({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
    this.dotColor,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final color = active ? Appcolor.accent : Appcolor.muted;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.012)),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? Appcolor.accent : Colors.transparent,
                width: Responsive.wp(0.005),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: Responsive.sp(0.04), color: color),
              SizedBox(width: Responsive.wp(0.015)),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: Responsive.sp(0.038),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (dotColor != null) ...[
                SizedBox(width: Responsive.wp(0.015)),
                Container(
                  width: Responsive.wp(0.015),
                  height: Responsive.wp(0.015),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InputPanel extends StatelessWidget {
  const _InputPanel({required this.inputController, required this.height});

  final TextEditingController inputController;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'If your program needs more than one input, put each value on its own line.',
          style: TextStyle(
            color: Appcolor.muted,
            fontSize: Responsive.sp(0.032),
            height: 1.4,
          ),
        ),
        SizedBox(height: Responsive.hp(0.01)),
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Appcolor.bg,
            borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
            border: Border.all(
              color: Appcolor.panelEdge,
              width: Responsive.wp(0.002),
            ),
          ),
          child: TextField(
            controller: inputController,
            maxLines: null,
            expands: true,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.038),
              fontFamily: 'monospace',
              height: 1.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(Responsive.wp(0.03)),
              hintText: 'e.g.\nAhmed\n25',
              hintStyle: TextStyle(
                color: Appcolor.muted,
                fontSize: Responsive.sp(0.035),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OutputPanel extends StatelessWidget {
  const _OutputPanel({
    required this.isLoading,
    required this.error,
    required this.output,
    required this.onCopy,
    required this.height,
  });

  final bool isLoading;
  final String error;
  final String output;
  final VoidCallback? onCopy;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: height,
        child: Center(
          child: SizedBox(
            width: Responsive.wp(0.07),
            height: Responsive.wp(0.07),
            child: CircularProgressIndicator(
              strokeWidth: Responsive.wp(0.005),
              valueColor: AlwaysStoppedAnimation(Appcolor.accent),
            ),
          ),
        ),
      );
    }

    final isError = error.isNotEmpty;
    final content = isError ? error : (output.isEmpty ? '' : output);
    final color = isError ? Appcolor.danger : Appcolor.success;

    if (content.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'Run your code to see the output here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.035),
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.all(Responsive.wp(0.03)),
      decoration: BoxDecoration(
        color: Appcolor.bg,
        borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
        border: Border.all(color: color, width: Responsive.wp(0.002)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.terminal,
                color: color,
                size: Responsive.sp(0.04),
              ),
              SizedBox(width: Responsive.wp(0.015)),
              Text(
                isError ? 'Error' : 'Output',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.sp(0.035),
                ),
              ),
              const Spacer(),
              if (onCopy != null)
                GestureDetector(
                  onTap: onCopy,
                  child: Icon(
                    Icons.copy_rounded,
                    color: color,
                    size: Responsive.sp(0.04),
                  ),
                ),
            ],
          ),
          SizedBox(height: Responsive.hp(0.01)),
          Expanded(
            child: SingleChildScrollView(
              child: SelectableText(
                content,
                style: TextStyle(
                  color: Appcolor.white,
                  fontSize: Responsive.sp(0.035),
                  fontFamily: isError ? null : 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LangAvatar extends StatelessWidget {
  const _LangAvatar({required this.label, required this.selected, this.size});

  final String label;
  final bool selected;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? Responsive.wp(0.08);

    return Container(
      width: avatarSize,
      height: avatarSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Appcolor.accent : Appcolor.panelEdge,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        child: Padding(
          padding: EdgeInsets.all(Responsive.wp(0.01)),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Appcolor.muted,
              fontSize: Responsive.sp(0.028),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _LineNumbers extends StatelessWidget {
  const _LineNumbers({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final lines = '\n'.allMatches(controller.text).length + 1;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.hp(0.015),
        horizontal: Responsive.wp(0.025),
      ),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Appcolor.panelEdge,
            width: Responsive.wp(0.002),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          lines,
          (i) => Text(
            '${i + 1}',
            style: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.04),
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Responsive.wp(0.025)),
        decoration: BoxDecoration(
          color: Appcolor.panel,
          borderRadius: BorderRadius.circular(Responsive.wp(0.035)),
          border: Border.all(
            color: Appcolor.panelEdge,
            width: Responsive.wp(0.002),
          ),
        ),
        child: Icon(icon, size: Responsive.sp(0.045), color: Appcolor.muted),
      ),
    );
  }
}