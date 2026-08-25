import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/main_view/profile/widgets/xpbar_profile.dart';
import 'package:url_launcher/url_launcher.dart';

Widget _iconForUrl(String url) {
  final lower = url.toLowerCase();
  if (lower.contains('facebook.com') || lower.contains('fb.com')) {
    return const FaIcon(FontAwesomeIcons.facebook);
  }
  if (lower.contains('instagram.com')) {
    return const FaIcon(FontAwesomeIcons.instagram);
  }
  if (lower.contains('twitter.com') || lower.contains('x.com')) {
    return const FaIcon(FontAwesomeIcons.xTwitter);
  }
  if (lower.contains('reddit.com'))
    return const FaIcon(FontAwesomeIcons.reddit);
  return const Icon(Icons.link_rounded);
}

Color _colorForUrl(String url) {
  final lower = url.toLowerCase();
  if (lower.contains('facebook.com') || lower.contains('fb.com')) {
    return const Color(0xFF1877F2);
  }
  if (lower.contains('instagram.com')) return const Color.fromRGBO(225, 48, 108, 1);
  if (lower.contains('twitter.com') || lower.contains('x.com')) {
    return const Color(0xFF1DA1F2);
  }
  if (lower.contains('reddit.com')) return const Color(0xFFFF4500);
  return Appcolor.muted;
}

/// زر "More info" صغير + القسم القابل للكشف تحته (XP bar، كل روابط
/// السوشال، تاريخ الانضمام). كل هالمعلومات موجودة بس ما إلها أولوية
/// بالعرض الافتراضي - نفس مبدأ Progressive Disclosure.
class ProfileMoreSection extends GetView<ProfileController> {
  const ProfileMoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => InkWell(
            onTap: controller.toggleMoreInfo,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Responsive.hp(0.006)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: controller.showMoreInfo.value
                        ? 'Less info'
                        : 'More info',
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.accent,
                    fontSize: Responsive.sp(0.032),
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: Responsive.wp(0.008)),
                  Icon(
                    controller.showMoreInfo.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.044),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (!controller.showMoreInfo.value) return const SizedBox.shrink();

          final profile = controller.profileData.value;
          final links = (profile?.socialLinks ?? [])
              .map((e) => e?.toString().trim() ?? '')
              .where((e) => e.isNotEmpty)
              .toList();

          return Padding(
            padding: EdgeInsets.only(top: Responsive.hp(0.008)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileXpBar(),
                if (links.isNotEmpty) ...[
                  SizedBox(height: Responsive.hp(0.014)),
                  Wrap(
                    spacing: Responsive.wp(0.025),
                    runSpacing: Responsive.hp(0.008),
                    children: links
                        .map(
                          (link) => _SocialPill(
                            icon: _iconForUrl(link),
                            color: _colorForUrl(link),
                            onTap: () => _openLink(link),
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (profile?.joinedAt != null) ...[
                  SizedBox(height: Responsive.hp(0.012)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: Responsive.sp(0.033),
                        color: Appcolor.muted,
                      ),
                      SizedBox(width: Responsive.wp(0.012)),
                      CustomText(
                        text: 'Joined ${profile!.joinedAt}',
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.muted,
                        fontSize: Responsive.sp(0.03),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(url.startsWith('http') ? url : 'https://$url');
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SocialPill extends StatelessWidget {
  final Widget icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialPill({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: Responsive.hp(0.044),
          height: Responsive.hp(0.044),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Appcolor.panel,
            shape: BoxShape.circle,
            border: Border.all(color: Appcolor.panelEdge),
          ),
          child: IconTheme(
            data: IconThemeData(color: color, size: Responsive.sp(0.04)),
            child: icon,
          ),
        ),
      ),
    );
  }
}
