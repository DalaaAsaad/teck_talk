import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/full_screen_images.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
// عدّل هالمسار حسب مكان الملف الحقيقي عندك
///
/// نفس نمط الكوفر + الأفاتار المتداخل، بيدعم [topRightAction]، [badge]，
/// وهلق كمان الدوس على أي وحدة منهم (لو موجودة فعلياً) بيفتحها بعرض
/// كامل الشاشة عبر FullScreenPhotoView.
///
/// ملاحظة تقنية: الـ Stack معطى SizedBox بارتفاع صريح (coverHeight +
/// avatarSize/2) بدل ما يعتمد على حجم الكوفر بس - غير هيك منطقة اللمس
/// (Hit-Test) بتنقطع عند حدود الكوفر ونص الأفاتار الفائض تحته (يلي فيه
/// الصورة نفسها والـ badge) بيصير غير قابل للمس، حتى لو ظاهر بصرياً.
class ProfileHero extends StatelessWidget {
  final String? coverImageUrl;
  final String avatarUrl;
  final Widget? topRightAction;
  final String? badge;

  const ProfileHero({
    super.key,
    required this.avatarUrl,
    this.coverImageUrl,
    this.topRightAction,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final coverHeight = Responsive.hp(0.13);
    final avatarSize = Responsive.wp(0.22);
    final totalHeight = coverHeight + avatarSize / 2;

    final hasCover = coverImageUrl != null && coverImageUrl!.isNotEmpty;
    final hasAvatar = avatarUrl.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.hp(0.01)),
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: coverHeight,
              child: GestureDetector(
                onTap: hasCover
                    ? () => _openFullScreen(context, coverImageUrl!)
                    : null,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: coverHeight,
                    decoration: BoxDecoration(
                      color: Appcolor.panel,
                      border: Border.all(color: Appcolor.panelEdge),
                    ),
                    child: hasCover
                        ? Image.network(
                            coverImageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _coverPlaceholder(),
                          )
                        : _coverPlaceholder(),
                  ),
                ),
              ),
            ),

            if (topRightAction != null)
              Positioned(
                top: Responsive.hp(0.012),
                right: Responsive.wp(0.025),
                child: topRightAction!,
              ),

            Positioned(
              left: Responsive.wp(0.05),
              top: coverHeight - avatarSize / 2,
              child: SizedBox(
                width: avatarSize,
                height: avatarSize,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: hasAvatar
                          ? () => _openFullScreen(context, avatarUrl)
                          : null,
                      child: Container(
                        width: avatarSize,
                        height: avatarSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Appcolor.bg, width: 4),
                          color: Appcolor.panelEdge,
                        ),
                        child: ClipOval(
                          child: hasAvatar
                              ? Image.network(
                                  avatarUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      _avatarPlaceholder(avatarSize),
                                )
                              : _avatarPlaceholder(avatarSize),
                        ),
                      ),
                    ),
                    if (badge != null && badge!.isNotEmpty)
                      Positioned(
                        bottom: -Responsive.hp(0.004),
                        right: -Responsive.wp(0.07),
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: Responsive.wp(0.06),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.wp(0.018),
                            vertical: Responsive.hp(0.003),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: Appcolor.accentDim,
                          ),
                          child: CustomText(
                            text: badge!,
                            styleType: TextStyleType.SMALL,
                            textColor: Appcolor.accent,
                            fontSize: Responsive.sp(0.024),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coverPlaceholder() {
    return Center(
      child: Icon(
        Icons.image_outlined,
        color: Appcolor.muted,
        size: Responsive.sp(0.08),
      ),
    );
  }

  Widget _avatarPlaceholder(double avatarSize) {
    return Icon(
      Icons.person_rounded,
      color: Appcolor.muted,
      size: avatarSize * 0.55,
    );
  }

  void _openFullScreen(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenPhotoView(photoUrls: [url]),
      ),
    );
  }
}
