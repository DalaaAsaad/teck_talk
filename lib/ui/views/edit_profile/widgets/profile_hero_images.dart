import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

/// قسم الصورة الشخصية + صورة الغلاف بنمط متداخل (Cover banner + Avatar
/// دائري فوقه بالزاوية).
///
/// ملاحظة مهمة: الـ Stack الخارجي معطى SizedBox بارتفاع صريح يشمل منطقة
/// تداخل الأفاتار (coverHeight + avatarSize/2)، حتى منطقة اللمس
/// (Hit-Test) تغطي زر تعديل الأفاتار كامل. بدون هيك، فلاتر بيرفض أي
/// لمسة إحداثياتها برا حجم الـ Stack الطبيعي (المحسوب من الكوفر بس)
/// حتى لو الأفاتار مرسوم هناك بصرياً بفضل clipBehavior: Clip.none —
/// هيك بالضبط كان زر تعديل الأفاتار ميت للمس رغم إنو ظاهر عالشاشة.
///
/// كمان: زر حذف (X) أحمر بيظهر بس لما يكون في صورة فعلياً (حسب
/// [hasCover]/[hasAvatar])، جنب زر التعديل.
class ProfileHeroImages extends StatelessWidget {
  final Widget? coverPreview;
  final Widget? avatarPreview;
  final bool hasCover;
  final bool hasAvatar;
  final VoidCallback onPickCover;
  final VoidCallback onPickAvatar;
  final VoidCallback onRemoveCover;
  final VoidCallback onRemoveAvatar;

  const ProfileHeroImages({
    super.key,
    required this.onPickCover,
    required this.onPickAvatar,
    required this.onRemoveCover,
    required this.onRemoveAvatar,
    required this.hasCover,
    required this.hasAvatar,
    this.coverPreview,
    this.avatarPreview,
  });

  @override
  Widget build(BuildContext context) {
    final coverHeight = Responsive.hp(0.16);
    final avatarSize = Responsive.wp(0.24);
    final totalHeight = coverHeight + avatarSize / 2;

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.hp(0.01)),
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // COVER
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: coverHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  height: coverHeight,
                  color: Appcolor.panel,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (coverPreview != null)
                        coverPreview!
                      else
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Appcolor.panelEdge),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      Positioned(
                        right: Responsive.wp(0.03),
                        top: Responsive.hp(0.014),
                        child: Row(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                    scale: animation,
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  ),
                              child: hasCover
                                  ? Row(
                                      key: const ValueKey('cover-remove'),
                                      children: [
                                        _RoundEditButton(
                                          icon: Icons.close_rounded,
                                          onTap: onRemoveCover,
                                          color: Appcolor.danger.withAlpha(130),
                                        ),
                                        SizedBox(width: Responsive.wp(0.02)),
                                      ],
                                    )
                                  : const SizedBox(
                                      key: ValueKey('cover-no-remove'),
                                    ),
                            ),
                            _RoundEditButton(
                              icon: Icons.photo_camera_outlined,
                              onTap: onPickCover,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // AVATAR — هلق ضمن حدود الـ SizedBox الجديدة فعلياً، مش فايض
            // عنها، فاللمس عم يشتغل بكل منطقتها.
            Positioned(
              left: Responsive.wp(0.05),
              top: coverHeight - avatarSize / 2,
              child: SizedBox(
                width: avatarSize,
                height: avatarSize,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Appcolor.bg, width: 4),
                        color: Appcolor.panelEdge,
                      ),
                      child: ClipOval(
                        child:
                            avatarPreview ??
                            Icon(
                              Icons.person_rounded,
                              color: Appcolor.muted,
                              size: avatarSize * 0.55,
                            ),
                      ),
                    ),
                    Positioned(
                      left: -2,
                      bottom: -2,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            ),
                        child: hasAvatar
                            ? _RoundEditButton(
                                key: const ValueKey('avatar-remove'),
                                icon: Icons.close_rounded,
                                onTap: onRemoveAvatar,
                                color: Appcolor.danger.withAlpha(130),
                                small: true,
                              )
                            : const SizedBox(key: ValueKey('avatar-no-remove')),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: _RoundEditButton(
                        icon: Icons.edit_rounded,
                        onTap: onPickAvatar,
                        small: true,
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
}

class _RoundEditButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool small;
  final Color? color;

  const _RoundEditButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.small = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = small ? Responsive.wp(0.075) : Responsive.wp(0.09);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? Appcolor.accent,
            shape: BoxShape.circle,
            border: Border.all(color: Appcolor.bg, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Appcolor.white,
            size: small ? Responsive.sp(0.032) : Responsive.sp(0.04),
          ),
        ),
      ),
    );
  }
}
