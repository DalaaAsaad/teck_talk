import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:url_launcher/url_launcher.dart';

/// صف روابط صغيرة تحت البايو (ويبسايت + لوكيشن). كل عنصر بيبين بس إذا
/// كانت قيمته موجودة فعلياً.
class ProfileMetaLinks extends StatelessWidget {
  final String? website;
  final String? location;

  const ProfileMetaLinks({super.key, this.website, this.location});

  @override
  Widget build(BuildContext context) {
    final hasWebsite = website != null && website!.trim().isNotEmpty;
    final hasLocation = location != null && location!.trim().isNotEmpty;

    if (!hasWebsite && !hasLocation) return const SizedBox.shrink();

    return Wrap(
      spacing: Responsive.wp(0.045),
      runSpacing: Responsive.hp(0.006),
      children: [
        if (hasLocation)
          _MetaItem(
            icon: Icons.location_on_outlined,
            label: location!.trim(),
            textColor: Appcolor.muted,
          ),
        if (hasWebsite)
          _MetaItem(
            icon: Icons.link_rounded,
            label: _displayUrl(website!.trim()),
            textColor: Appcolor.accent,
            onTap: () => _openLink(website!.trim()),
          ),
      ],
    );
  }

  String _displayUrl(String url) {
    return url.replaceFirst(RegExp(r'^https?://'), '').replaceFirst(
          RegExp(r'/$'),
          '',
        );
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.tryParse(
      url.startsWith('http') ? url : 'https://$url',
    );
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color textColor;
  final VoidCallback? onTap;

  const _MetaItem({
    required this.icon,
    required this.label,
    required this.textColor,
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
          Icon(icon, size: Responsive.sp(0.037), color: Appcolor.muted),
          SizedBox(width: Responsive.wp(0.01)),
          CustomText(
            text: label,
            styleType: TextStyleType.CUSTOM,
            textColor: textColor,
            fontSize: Responsive.sp(0.033),
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
