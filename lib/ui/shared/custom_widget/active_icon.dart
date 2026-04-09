import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class ActiveIcon extends StatelessWidget {
  final Icon icon;
  final Icon iconIsActive;
  final Color color;
  final String numOfInteractors;
  final RxBool isActive;
  final Function function;
  ActiveIcon({
    super.key,
    required this.icon,
    required this.iconIsActive,
    required this.numOfInteractors,
    required this.color,
    required this.isActive,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              function();
            },
            icon: isActive.value ? iconIsActive : icon,
            color: isActive.value ? color : Appcolor.white.withAlpha(150),
            iconSize: screenWidth(15),
          ),
          CustomText(text: numOfInteractors, styleType: TextStyleType.SMALL),
        ],
      ),
    );
  }
}
