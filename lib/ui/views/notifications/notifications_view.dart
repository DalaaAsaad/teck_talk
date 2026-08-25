import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/notifications_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/notifications/widgets/notification_tile.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.notifications.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(color: Appcolor.accent),
                  );
                }

                if (controller.notifications.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  color: Appcolor.accent,
                  backgroundColor: Appcolor.panel,
                  onRefresh: controller.loadNotifications,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200) {
                        controller.loadMoreNotifications();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.wp(0.04),
                        vertical: Responsive.hp(0.01),
                      ),
                      itemCount:
                          controller.notifications.length +
                          (controller.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.notifications.length) {
                          return Padding(
                            padding: EdgeInsets.all(Responsive.wp(0.04)),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Appcolor.accent,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }

                        final notification = controller.notifications[index];
                        return NotificationTile(
                          notification: notification,
                          onTap: () => controller.markAsRead(notification),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Responsive.wp(0.18),
            height: Responsive.wp(0.18),
            decoration: BoxDecoration(
              color: Appcolor.panel,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.notifications_none_rounded,
              color: Appcolor.muted,
              size: Responsive.sp(0.07),
            ),
          ),
          SizedBox(height: Responsive.hp(0.016)),
          CustomText(
            text: 'No notifications yet',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.muted,
            fontSize: Responsive.sp(0.037),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Responsive.wp(0.02),
        end: Responsive.wp(0.045),
        top: Responsive.hp(0.01),
        bottom: Responsive.hp(0.008),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Appcolor.white,
              size: Responsive.sp(0.05),
            ),
          ),
          CustomText(
            text: 'Notifications',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.05),
            fontWeight: FontWeight.w700,
          ),
          const Spacer(),
          Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: controller.unreadCount.value > 0
                  ? TextButton(
                      key: const ValueKey('mark-all'),
                      onPressed: controller.markAllAsRead,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.wp(0.025),
                        ),
                      ),
                      child: CustomText(
                        text: 'Mark all read',
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.accent,
                        fontSize: Responsive.sp(0.033),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('mark-all-empty')),
            ),
          ),
        ],
      ),
    );
  }
}