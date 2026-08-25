import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// شرائط التاغز بستايل موحّد مع chips التاغز المستخدمة بشاشات Create/Edit
/// Blog. [tags] عناصرها List<dynamic> (ممكن تكون String أو Map فيها
/// 'name') - بنتعامل مع الحالتين دفاعياً.
class ProfileTags extends StatelessWidget {
  final List<dynamic> tags;

  const ProfileTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    final names = tags
        .map((tag) {
          if (tag is Map) return tag['name']?.toString() ?? '';
          return tag.toString();
        })
        .where((name) => name.isNotEmpty)
        .toList();

    if (names.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: Responsive.wp(0.02),
      runSpacing: Responsive.hp(0.01),
      children: names
          .map(
            (name) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.wp(0.03),
                vertical: Responsive.hp(0.007),
              ),
              decoration: BoxDecoration(
                color: Appcolor.accentDim,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                text: name,
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.accent,
                fontSize: Responsive.sp(0.032),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
          .toList(),
    );
  }
}
