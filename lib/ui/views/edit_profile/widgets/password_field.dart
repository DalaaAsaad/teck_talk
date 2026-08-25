import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// حقل كلمة مرور بستايل موحّد مع GlassInputField، مع زر عين لإظهار/
/// إخفاء النص. الحالة (obscure) محلية بالويدجت نفسه عبر RxBool صغيرة
/// (بلا حاجة لـ StatefulWidget).
class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;

  PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
  });

  final RxBool _obscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Responsive.hp(0.06),
          padding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.045)),
          decoration: BoxDecoration(
            color: Appcolor.panel,
            borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
            border: Border.all(
              color: errorText != null ? Appcolor.danger : Appcolor.panelEdge,
              width: errorText != null ? 1.2 : Responsive.wp(0.0025),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => TextField(
                    controller: controller,
                    obscureText: _obscure.value,
                    cursorColor: Appcolor.accent,
                    style: TextStyle(
                      color: Appcolor.white,
                      fontSize: Responsive.sp(0.04),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Appcolor.muted,
                        fontSize: Responsive.sp(0.04),
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () => _obscure.value = !_obscure.value,
                  child: Icon(
                    _obscure.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Appcolor.muted,
                    size: Responsive.sp(0.05),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: Responsive.hp(0.006)),
          Text(
            errorText!,
            style: TextStyle(
              color: Appcolor.danger,
              fontSize: Responsive.sp(0.03),
            ),
          ),
        ],
      ],
    );
  }
}
