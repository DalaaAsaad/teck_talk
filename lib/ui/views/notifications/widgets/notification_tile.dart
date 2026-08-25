import 'package:flutter/material.dart';
import 'package:tech_talk/core/data/models/notification_model.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

IconData _iconForType(String type) {
  final lower = type.toLowerCase();
  if (lower.contains('like')) return Icons.favorite_rounded;
  if (lower.contains('comment')) return Icons.comment_rounded;
  if (lower.contains('follow')) return Icons.person_add_rounded;
  if (lower.contains('mention')) return Icons.alternate_email_rounded;
  if (lower.contains('highlight')) return Icons.star_rounded;
  return Icons.notifications_rounded;
}

/// كارد مدوّر منفصل لكل إشعار (بدل صف مسطح ممتد لعرض الشاشة كامل)،
/// بانتقال ناعم (AnimatedContainer + Curve) بين حالة مقروء/غير مقروء
/// بدل التغيير الفوري.
class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead;

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.hp(0.01)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.wp(0.035),
              vertical: Responsive.hp(0.012),
            ),
            decoration: BoxDecoration(
              color: isRead ? Appcolor.panel : Appcolor.accentDim,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isRead
                    ? Appcolor.panelEdge
                    : Appcolor.accent.withOpacity(0.35),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Responsive.wp(0.1),
                  height: Responsive.wp(0.1),
                  decoration: BoxDecoration(
                    color: Appcolor.accentDim,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    _iconForType(notification.type),
                    color: Appcolor.accent,
                    size: Responsive.sp(0.045),
                  ),
                ),
                SizedBox(width: Responsive.wp(0.03)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: notification.title,
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.white,
                        fontSize: Responsive.sp(0.037),
                        fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                      ),
                      if (notification.body.isNotEmpty) ...[
                        SizedBox(height: Responsive.hp(0.003)),
                        CustomText(
                          text: notification.body,
                          styleType: TextStyleType.CUSTOM,
                          textColor: Appcolor.muted,
                          fontSize: Responsive.sp(0.033),
                        ),
                      ],
                      SizedBox(height: Responsive.hp(0.006)),
                      CustomText(
                        text: notification.createdAt,
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.muted,
                        fontSize: Responsive.sp(0.028),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: !isRead
                      ? Container(
                          key: const ValueKey('unread-dot'),
                          width: Responsive.wp(0.022),
                          height: Responsive.wp(0.022),
                          margin: EdgeInsets.only(top: Responsive.hp(0.006)),
                          decoration: BoxDecoration(
                            color: Appcolor.accent,
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox.shrink(key: ValueKey('no-dot')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
