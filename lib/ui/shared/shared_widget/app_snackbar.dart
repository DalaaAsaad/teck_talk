import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';


class AppSnackBar {
  static void success(String message, {String title = 'Success'}) {
    _show(
      title: title,
      message: message,
      accentColor: Appcolor.success,
      icon: Icons.check_circle_rounded,
    );
  }

  static void error(String message, {String title = 'Error'}) {
    _show(
      title: title,
      message: message,
      accentColor: Appcolor.red,
      icon: Icons.error_rounded,
    );
  }

  static void _show({
    required String title,
    required String message,
    required Color accentColor,
    required IconData icon,
  }) {
    Get.closeCurrentSnackbar();
    Get.snackbar(
      '',
      '',
      titleText: _SnackContent(
        title: title,
        message: message,
        accentColor: accentColor,
        icon: icon,
      ),
      messageText: const SizedBox.shrink(),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Appcolor.panel,
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.zero,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      borderColor: accentColor.withOpacity(0.35),
      borderWidth: 1.5,
      boxShadows: [
        BoxShadow(
          color: accentColor.withOpacity(0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Snack content widget
// ─────────────────────────────────────────────
class _SnackContent extends StatelessWidget {
  final String title;
  final String message;
  final Color accentColor;
  final IconData icon;

  const _SnackContent({
    required this.title,
    required this.message,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Icon badge ────────────────────────────────
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: accentColor.withOpacity(0.25),
                width: 1,
              ),
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),

          const SizedBox(width: 13),

          // ── Left accent line ──────────────────────────
          Container(
            width: 1.5,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(width: 13),

          // ── Text block ────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Appcolor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  message,
                  style: const TextStyle(
                    color: Appcolor.muted,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
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
