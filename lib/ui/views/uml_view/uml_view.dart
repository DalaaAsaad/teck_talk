import 'package:flutter/material.dart';
import 'package:tech_talk/controllers/uml_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/back_button_custom.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/uml_view/widgets/description_field.dart';
import 'package:tech_talk/ui/views/uml_view/widgets/diagram_image_card.dart';
import 'package:tech_talk/ui/views/uml_view/widgets/generkate_button.dart';
import 'package:tech_talk/ui/views/uml_view/widgets/result_buttons.dart';
import 'package:tech_talk/ui/views/uml_view/widgets/title_uml.dart';

class UmlView extends StatefulWidget {
  const UmlView({super.key});

  @override
  State<UmlView> createState() => _UmlViewState();
}

class _UmlViewState extends State<UmlView> {
  late final UmlController _controller;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _controller = UmlController();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.bg,
        appBar: AppBar(
          backgroundColor: Appcolor.bg,
          elevation: 0,
          toolbarHeight: Responsive.hp(0.09),
          leading: const BackButtonCustom(),
          title: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return TitleUml(isResult: _controller.state == UmlState.result);
            },
          ),
        ),
        body: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final bool isResult = _controller.state == UmlState.result;
            final bool isLoading = _controller.state == UmlState.loading;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.wp(0.05),
                vertical: Responsive.hp(0.02),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isResult ? 'GENERATED DIAGRAM' : 'DESCRIPTION',
                    style: TextStyle(
                      color: Appcolor.muted,
                      fontSize: Responsive.sp(0.035),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),

                  SizedBox(height: Responsive.hp(0.012)),

                  if (_controller.errorMessage != null && !isLoading)
                    Padding(
                      padding: EdgeInsets.only(bottom: Responsive.hp(0.012)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(Responsive.sp(0.03)),
                        decoration: BoxDecoration(
                          color: Appcolor.danger.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(Responsive.sp(0.02)),
                          border: Border.all(color: Appcolor.danger, width: 0.6),
                        ),
                        child: Text(
                          _controller.errorMessage!,
                          style: TextStyle(
                            color: Appcolor.danger,
                            fontSize: Responsive.sp(0.03),
                          ),
                        ),
                      ),
                    ),

                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: isResult
                          ? DiagramImageCard(
                              key: const ValueKey('image'),
                              imageBytes: _controller.diagramImage,
                            )
                          : DescriptionField(
                              key: const ValueKey('input'),
                              textController: _textController,
                              maxLength: _controller.maxLength,
                              isLoading: isLoading,
                              onChanged: _controller.onDescriptionChanged,
                            ),
                    ),
                  ),

                  SizedBox(height: Responsive.hp(0.012)),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.wp(0.02),
                      vertical: Responsive.hp(0.01),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            isResult
                                ? 'Tap regenerate to try again'
                                : 'Be as detailed as possible',
                            style: TextStyle(
                              color: Appcolor.muted,
                              fontSize: Responsive.sp(0.028),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!isResult) SizedBox(width: Responsive.wp(0.02)),
                        if (!isResult)
                          Text(
                            '${_controller.charCount} / ${_controller.maxLength}',
                            style: TextStyle(
                              color: Appcolor.muted,
                              fontSize: Responsive.sp(0.028),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: Responsive.hp(0.01)),

                  if (isResult)
                    ResultButtons(
                      exportPressed: _controller.exportPressed,
                      onRegenerate: _controller.regenerate,
                      onExport: _controller.exportPng,
                    )
                  else
                    GenerateButton(
                      isLoading: isLoading,
                      canGenerate: _controller.canGenerate,
                      onGenerate: _controller.generateDiagram,
                    ),

                  SizedBox(height: Responsive.hp(0.015)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}