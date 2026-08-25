import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/profile_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:url_launcher/url_launcher.dart';

/// نسخة "مدمجة" من معلومات البروفايل - كل شي (اسم/يوزرنيم/إحصائيات/بايو/
/// لوكيشن/ويبسايت/تاغز) بكتلة واحدة متقاربة، بدل أقسام منفصلة بمسافات
/// كبيرة. أقصى تاغين ظاهرين + شارة "+N" لو في أكتر.
class ProfileMergedInfo extends GetView<ProfileController> {
  const ProfileMergedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profileData.value;
    if (profile == null) return const SizedBox.shrink();

    final bio = profile.bio?.trim() ?? '';
    final location = profile.location?.trim() ?? '';
    final website = profile.website?.trim() ?? '';

    final tagNames = profile.tags
        .map((tag) => tag is Map ? (tag['name']?.toString() ?? '') : tag.toString())
        .where((name) => name.isNotEmpty)
        .toList();

    final hasMeta = location.isNotEmpty || website.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: CustomText(
                text: profile.name,
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.046),
                fontWeight: FontWeight.w700,
                textColor: Appcolor.white,
              ),
            ),
            SizedBox(width: Responsive.wp(0.018)),
            Flexible(
              child: CustomText(
                text: '@${profile.username}',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.muted,
                fontSize: Responsive.sp(0.033),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.hp(0.008)),
        Wrap(
          spacing: Responsive.wp(0.035),
          runSpacing: Responsive.hp(0.003),
          children: [
            _StatText(value: profile.postsCount, label: 'posts'),
            _StatText(value: profile.followersCount, label: 'followers'),
            _StatText(value: profile.blogsCount, label: 'blogs'),
          ],
        ),
        if (bio.isNotEmpty) ...[
          SizedBox(height: Responsive.hp(0.008)),
          CustomText(
            text: bio,
            styleType: TextStyleType.CUSTOM,
            fontSize: Responsive.sp(0.033),
            fontWeight: FontWeight.w400,
            textColor: Appcolor.muted,
          ),
        ],
        if (hasMeta) ...[
          SizedBox(height: Responsive.hp(0.005)),
          Wrap(
            spacing: Responsive.wp(0.03),
            runSpacing: Responsive.hp(0.003),
            children: [
              if (location.isNotEmpty) _MetaChip(icon: Icons.location_on_outlined, text: location),
              if (website.isNotEmpty)
                _MetaChip(
                  icon: Icons.link_rounded,
                  text: _displayUrl(website),
                  color: Appcolor.accent,
                  onTap: () => _openLink(website),
                ),
            ],
          ),
        ],
        if (tagNames.isNotEmpty) ...[
          SizedBox(height: Responsive.hp(0.007)),
          Wrap(
            spacing: Responsive.wp(0.015),
            runSpacing: Responsive.hp(0.005),
            children: [
              for (final name in tagNames.take(2)) _TagChip(text: name),
              if (tagNames.length > 2) _TagChip(text: '+${tagNames.length - 2}'),
            ],
          ),
        ],
      ],
    );
  }

  String _displayUrl(String url) {
    return url
        .replaceFirst(RegExp(r'^https?://'), '')
        .replaceFirst(RegExp(r'/$'), '');
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(url.startsWith('http') ? url : 'https://$url');
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _StatText extends StatelessWidget {
  final int value;
  final String label;

  const _StatText({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$value ',
            style: TextStyle(
              color: Appcolor.white,
              fontSize: Responsive.sp(0.032),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: label,
            style: TextStyle(
              color: Appcolor.muted,
              fontSize: Responsive.sp(0.032),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final VoidCallback? onTap;

  const _MetaChip({
    required this.icon,
    required this.text,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Responsive.sp(0.035), color: Appcolor.muted),
          SizedBox(width: Responsive.wp(0.008)),
          CustomText(
            text: text,
            styleType: TextStyleType.CUSTOM,
            textColor: color ?? Appcolor.muted,
            fontSize: Responsive.sp(0.031),
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;

  const _TagChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.025),
        vertical: Responsive.hp(0.003),
      ),
      decoration: BoxDecoration(
        color: Appcolor.accentDim,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: text,
        styleType: TextStyleType.CUSTOM,
        textColor: Appcolor.accent,
        fontSize: Responsive.sp(0.028),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}