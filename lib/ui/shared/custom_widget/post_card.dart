import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/full_screen_images.dart';
import 'package:tech_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/custom_widget/tag_widget.dart';
import 'package:tech_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:tech_talk/ui/shared/dialogs/code_dialog.dart';
import 'package:tech_talk/ui/shared/shared_widget/NumberFormatter.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/views/code_view/code_view.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String userAvatarUrl;
  final dynamic createdAt;

  final String title;
  final String body;
  final List<String> tags;
  final List<String> photoUrls;

  final String? code;
  final String? codeLanguage;

  final int likesCount;
  final int commentsCount;
  final int? viewsCount;
  final bool isLikedByUser;
  final bool isSaved;

  final VoidCallback onFavorite;
  final VoidCallback onComment;
  final VoidCallback onSaved;

  final bool isOwner;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  final bool showDivider;

  const PostCard({
    super.key,
    required this.userName,
    required this.userAvatarUrl,
    required this.createdAt,
    required this.title,
    required this.body,
    this.tags = const [],
    this.photoUrls = const [],
    this.code,
    this.codeLanguage,
    required this.likesCount,
    required this.commentsCount,
    this.viewsCount,
    required this.isLikedByUser,
    required this.isSaved,
    required this.onFavorite,
    required this.onComment,
    required this.onSaved,
    this.isOwner = false,
    this.onEdit,
    this.onDelete,
    this.showDivider = true,
  });

  bool get _hasCode => code != null && code!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.04),
        vertical: Responsive.hp(0.01),
      ),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: Appcolor.panelEdge.withOpacity(0.8),
                  width: 2,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // HEADER
          // ============================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: UsetInfoHeader(
                  nameProfile: userName,
                  date: createdAt,
                  imageProfile: userAvatarUrl,
                  moveToUserProfile: () {
                    Get.toNamed(AppRoutes.userProfile, arguments: userName);
                  },
                ),
              ),
              SizedBox(width: Responsive.wp(0.02)),
              if (isOwner)
                PostOptionsButton(
                  hasCode: _hasCode,
                  onViewCode: () {
                    Get.dialog(
                      CodeDialog(
                        codeView: CodeView(
                          code: code,
                          mode: CodeViewMode.view,
                          isdialog: true,
                          languageCode: codeLanguage,
                        ),
                      ),
                    );
                  },
                  onEdit: onEdit,
                  onDelete: onDelete,
                )
              else if (_hasCode)
                ViewCodeButton(code, codeLanguage),
            ],
          ),

          SizedBox(height: Responsive.hp(0.009)),

          // ============================================================
          // TITLE + BODY
          // ============================================================
          CustomText(
            text: title,
            styleType: TextStyleType.CUSTOM,
            fontSize: Responsive.sp(0.042),
            fontWeight: FontWeight.w600,
            textColor: Appcolor.white,
          ),
          CustomText(
            text: body,
            styleType: TextStyleType.CUSTOM,
            fontSize: Responsive.sp(0.033),
            fontWeight: FontWeight.w400,
            textColor: Appcolor.muted,
          ),

          // ============================================================
          // TAGS
          // ============================================================
          if (tags.isNotEmpty) ...[
            SizedBox(height: Responsive.hp(0.006)),
            Wrap(
              spacing: Responsive.wp(0.012),
              runSpacing: Responsive.hp(0.004),
              children: tags.map((t) => TagWidget(text: t)).toList(),
            ),
          ],

          // ============================================================
          // PHOTOS
          // ============================================================
          if (photoUrls.isNotEmpty) ...[
            SizedBox(height: Responsive.hp(0.008)),
            ClipRRect(
              borderRadius: BorderRadius.circular(Responsive.wp(0.03)),
              child: SizedBox(
                height: Responsive.hp(0.19),
                child: PageView.builder(
                  itemCount: photoUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => FullScreenPhotoView(
                              photoUrls: photoUrls,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: photoUrls[index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Appcolor.panel,
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: Responsive.wp(0.05),
                            height: Responsive.wp(0.05),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Appcolor.accent,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Appcolor.panel,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: Appcolor.muted,
                            size: Responsive.sp(0.06),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],

          // ============================================================
          // ACTIONS
          // ============================================================
          Row(
            children: [
              ActiveIcon(
                icon: Icons.favorite_border,
                iconIsActive: Icons.favorite,
                numOfInteractors: NumberFormatter.format(likesCount),
                color: Appcolor.accent,
                isActive: isLikedByUser,
                function: onFavorite,
              ),
              SizedBox(width: Responsive.wp(0.035)),
              ActiveIcon(
                icon: Icons.comment_bank_outlined,

                iconIsActive: Icons.comment_bank_outlined,

                numOfInteractors: NumberFormatter.format(commentsCount),
                color: Appcolor.white,
                isActive: true,
                function: onComment,
              ),
              SizedBox(width: Responsive.wp(0.035)),
              ActiveIcon(
                icon: Icons.bookmark_border,
                iconIsActive: Icons.bookmark,
                numOfInteractors: null,
                color: Appcolor.white,
                isActive: isSaved,
                function: onSaved,
              ),
              if (viewsCount != null) ...[
                const Spacer(),
                Icon(
                  Icons.remove_red_eye_outlined,
                  size: Responsive.sp(0.048),
                  color: Appcolor.label,
                ),
                SizedBox(width: Responsive.wp(0.01)),
                CustomText(
                  text: NumberFormatter.format(viewsCount!),
                  styleType: TextStyleType.SMALL,
                  textColor: Appcolor.label,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// VIEW CODE BUTTON (مشترك) — بلا بوردر، خلفية خفيفة بس
// ============================================================================
Widget ViewCodeButton(String? code, String? languageCode) {
  return InkWell(
    borderRadius: BorderRadius.circular(999),
    splashColor: Appcolor.accent.withOpacity(0.2),
    onTap: () {
      Get.dialog(
        CodeDialog(
          codeView: CodeView(
            code: code,
            mode: CodeViewMode.view,
            isdialog: true,
            languageCode: languageCode,
          ),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.024),
        vertical: Responsive.hp(0.007),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Appcolor.accentDim,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Code",
            styleType: TextStyleType.SMALL,
            textColor: Appcolor.accent,
          ),
          SizedBox(width: Responsive.wp(0.008)),
          Icon(
            Icons.arrow_outward_rounded,
            size: Responsive.sp(0.032),
            color: Appcolor.accent,
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// OWNER OPTIONS (Home فقط)
// ============================================================================
enum _PostOption { viewCode, edit, delete }

class PostOptionsButton extends StatelessWidget {
  final bool hasCode;
  final VoidCallback onViewCode;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PostOptionsButton({
    super.key,
    required this.hasCode,
    required this.onViewCode,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PostOption>(
      icon: Icon(Icons.more_horiz_rounded, color: Appcolor.muted),
      color: Appcolor.panel,
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.35),
      surfaceTintColor: Appcolor.panel,
      padding: EdgeInsets.zero,
      menuPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Appcolor.panelEdge),
      ),
      constraints: BoxConstraints(minWidth: Responsive.wp(0.44)),
      offset: Offset(0, Responsive.hp(0.045)),
      popUpAnimationStyle: AnimationStyle(
        curve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 200),
        reverseCurve: Curves.easeInCubic,
        reverseDuration: const Duration(milliseconds: 140),
      ),
      itemBuilder: (context) {
        final items = <PopupMenuEntry<_PostOption>>[];

        if (hasCode) {
          items.add(
            PopupMenuItem(
              value: _PostOption.viewCode,
              height: Responsive.hp(0.06),
              child: _MenuRow(
                icon: Icons.code_rounded,
                iconBg: Appcolor.accentDim,
                iconColor: Appcolor.accent,
                label: "View Code",
              ),
            ),
          );
          items.add(_menuDivider());
        }

        items.add(
          PopupMenuItem(
            value: _PostOption.edit,
            height: Responsive.hp(0.06),
            child: _MenuRow(
              icon: Icons.edit_outlined,
              iconBg: Appcolor.panelEdge,
              iconColor: Appcolor.white,
              label: "Edit",
            ),
          ),
        );
        items.add(_menuDivider());
        items.add(
          PopupMenuItem(
            value: _PostOption.delete,
            height: Responsive.hp(0.06),
            child: _MenuRow(
              icon: Icons.delete_outline_rounded,
              iconBg: const Color(0x1FE05C5C),
              iconColor: const Color(0xFFE05C5C),
              label: "Delete",
              labelColor: const Color(0xFFE05C5C),
            ),
          ),
        );

        return items;
      },
      onSelected: (value) {
        switch (value) {
          case _PostOption.viewCode:
            onViewCode();
            break;
          case _PostOption.edit:
            onEdit?.call();
            break;
          case _PostOption.delete:
            _confirmDelete(context);
            break;
        }
      },
    );
  }

  PopupMenuEntry<_PostOption> _menuDivider() {
    return PopupMenuItem<_PostOption>(
      enabled: false,
      height: 1,
      padding: EdgeInsets.zero,
      child: Container(height: 1, color: Appcolor.panelEdge),
    );
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.06)),
        child: Container(
          padding: EdgeInsets.all(Responsive.wp(0.055)),
          decoration: BoxDecoration(
            color: Appcolor.panel,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Appcolor.panelEdge),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Responsive.wp(0.16),
                height: Responsive.wp(0.16),
                decoration: const BoxDecoration(
                  color: Color(0x1FE05C5C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFE05C5C),
                  size: 32,
                ),
              ),
              SizedBox(height: Responsive.hp(0.02)),
              CustomText(
                text: "Delete this post?",
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.05),
                fontWeight: FontWeight.w700,
                textColor: Appcolor.white,
              ),
              SizedBox(height: Responsive.hp(0.01)),
              CustomText(
                text: "This action is permanent and cannot be undone.",
                styleType: TextStyleType.BODY,
                textColor: Appcolor.muted,
              ),
              SizedBox(height: Responsive.hp(0.028)),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.hp(0.015),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Appcolor.panelEdge),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Cancel",
                          styleType: TextStyleType.SMALL,
                          fontWeight: FontWeight.w600,
                          textColor: Appcolor.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.wp(0.03)),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Get.back();
                        onDelete?.call();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.hp(0.015),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE05C5C),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: "Delete",
                          styleType: TextStyleType.SMALL,
                          fontWeight: FontWeight.w600,
                          textColor: Appcolor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final Color? labelColor;

  const _MenuRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(0.035),
        vertical: Responsive.hp(0.006),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.wp(0.08),
            height: Responsive.wp(0.08),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, size: Responsive.sp(0.038), color: iconColor),
          ),
          SizedBox(width: Responsive.wp(0.03)),
          CustomText(
            text: label,
            styleType: TextStyleType.SMALL,
            fontWeight: FontWeight.w500,
            textColor: labelColor ?? Appcolor.white,
          ),
        ],
      ),
    );
  }
}
