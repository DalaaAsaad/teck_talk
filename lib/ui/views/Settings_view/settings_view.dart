import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/settings_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/Settings_view/widgets/segmented_selector.dart';
import 'package:tech_talk/ui/views/Settings_view/widgets/settings_switch_tile.dart';
import 'package:tech_talk/ui/views/edit_profile/widgets/elevated_card.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

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
                    controller.settings.value == null) {
                  return Center(
                    child: CircularProgressIndicator(color: Appcolor.accent),
                  );
                }

                final settings = controller.settings.value;
                if (settings == null) {
                  return Center(
                    child: CustomText(
                      text: 'Could not load settings',
                      styleType: TextStyleType.CUSTOM,
                      textColor: Appcolor.muted,
                      fontSize: Responsive.sp(0.037),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.wp(0.045),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Responsive.hp(0.008)),
                      ElevatedCard(
                        title: 'Appearance',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Theme',
                              styleType: TextStyleType.CUSTOM,
                              textColor: Appcolor.muted,
                              fontSize: Responsive.sp(0.032),
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: Responsive.hp(0.01)),
                            SegmentedSelector(
                              selectedValue: settings.theme,
                              isSaving: controller.savingKeys.contains('theme'),
                              onChanged: controller.setTheme,
                              options: const [
                                SegmentedOption(
                                  value: 'light',
                                  label: 'Light',
                                  icon: Icons.light_mode_outlined,
                                ),
                                SegmentedOption(
                                  value: 'dark',
                                  label: 'Dark',
                                  icon: Icons.dark_mode_outlined,
                                ),
                                SegmentedOption(
                                  value: 'system',
                                  label: 'System',
                                  icon: Icons.settings_suggest_outlined,
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.hp(0.004)),
                            CustomText(
                              text:
                                  '"System" matches your phone\'s theme automatically',
                              styleType: TextStyleType.CUSTOM,
                              textColor: Appcolor.muted,
                              fontSize: Responsive.sp(0.028),
                            ),
                            SizedBox(height: Responsive.hp(0.018)),
                            CustomText(
                              text: 'Language',
                              styleType: TextStyleType.CUSTOM,
                              textColor: Appcolor.muted,
                              fontSize: Responsive.sp(0.032),
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: Responsive.hp(0.01)),
                            SegmentedSelector(
                              selectedValue: settings.language,
                              isSaving: controller.savingKeys.contains(
                                'language',
                              ),
                              onChanged: controller.setLanguage,
                              options: const [
                                SegmentedOption(value: 'en', label: 'English'),
                                SegmentedOption(value: 'ar', label: 'العربية'),
                                SegmentedOption(value: 'fr', label: 'Français'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.hp(0.02)),
                      ElevatedCard(
                        title: 'Notification Channels',
                        child: Column(
                          children: [
                            SettingsSwitchTile(
                              title: 'In-app notifications',
                              subtitle: 'Master switch for all in-app alerts',
                              value: settings.notifications.channels.inApp,
                              isSaving: controller.savingKeys.contains(
                                'channel_in_app',
                              ),
                              onChanged: controller.setChannelInApp,
                            ),
                            _divider(),
                            SettingsSwitchTile(
                              title: 'Push notifications',
                              subtitle:
                                  'Alerts sent directly to your device, even when the app is closed',
                              value: settings.notifications.channels.push,
                              isSaving: controller.savingKeys.contains(
                                'channel_push',
                              ),
                              onChanged: controller.setChannelPush,
                            ),
                            _divider(),
                            SettingsSwitchTile(
                              title: 'Email notifications',
                              subtitle:
                                  'Alerts sent to the email address on your account',
                              value: settings.notifications.channels.email,
                              isSaving: controller.savingKeys.contains(
                                'channel_email',
                              ),
                              onChanged: controller.setChannelEmail,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.hp(0.02)),
                      ElevatedCard(
                        title: 'Notify Me About',
                        child: Column(
                          children: [
                            _eventTile(
                              controller,
                              'likes',
                              'Likes',
                              'When someone likes your post or blog',
                              settings.notifications.events.likes,
                            ),
                            _divider(),
                            _eventTile(
                              controller,
                              'comments',
                              'Comments',
                              'When someone comments on your content',
                              settings.notifications.events.comments,
                            ),
                            _divider(),
                            _eventTile(
                              controller,
                              'follows',
                              'New followers',
                              'When someone starts following you',
                              settings.notifications.events.follows,
                            ),
                            _divider(),
                            _eventTile(
                              controller,
                              'mentions',
                              'Mentions',
                              'When someone tags you in a post or comment',
                              settings.notifications.events.mentions,
                            ),
                            _divider(),
                            _eventTile(
                              controller,
                              'highlights',
                              'Highlights',
                              'When your content is featured by the app',
                              settings.notifications.events.highlights,
                            ),
                            _divider(),
                            _eventTile(
                              controller,
                              'verification',
                              'Verification updates',
                              'Changes to your account verification status',
                              settings.notifications.events.verification,
                            ),
                            _divider(),
                            _eventTile(
                              controller,
                              'product_updates',
                              'Product updates',
                              'News about new features and improvements',
                              settings.notifications.events.productUpdates,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.hp(0.02)),
                      ElevatedCard(
                        title: 'Privacy',
                        child: Column(
                          children: [
                            SettingsSwitchTile(
                              title: 'Show email on profile',
                              subtitle:
                                  'Other users can see your email address',
                              value: settings.privacy.showEmail,
                              isSaving: controller.savingKeys.contains(
                                'show_email',
                              ),
                              onChanged: controller.setShowEmail,
                            ),
                            _divider(),
                            SettingsSwitchTile(
                              title: 'Discoverable profile',
                              subtitle:
                                  'Show up in search and public discovery',
                              value: settings.privacy.profileDiscoverable,
                              isSaving: controller.savingKeys.contains(
                                'profile_discoverable',
                              ),
                              onChanged: controller.setProfileDiscoverable,
                            ),
                            _divider(),
                            SettingsSwitchTile(
                              title: 'Allow followers',
                              subtitle: 'Let other users follow you',
                              value: settings.privacy.allowFollows,
                              isSaving: controller.savingKeys.contains(
                                'allow_follows',
                              ),
                              onChanged: controller.setAllowFollows,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.hp(0.04)),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventTile(
    SettingsController controller,
    String key,
    String title,
    String subtitle,
    bool value,
  ) {
    return SettingsSwitchTile(
      title: title,
      subtitle: subtitle,
      value: value,
      isSaving: controller.savingKeys.contains('event_$key'),
      onChanged: (v) => controller.setEvent(key, v),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.012)),
      child: Container(height: 1, color: Appcolor.panelEdge.withOpacity(0.5)),
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
            text: 'Settings',
            styleType: TextStyleType.CUSTOM,
            textColor: Appcolor.white,
            fontSize: Responsive.sp(0.05),
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
