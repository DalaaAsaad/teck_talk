import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/views/code_view/code_model.dart';
import 'package:tech_talk/ui/shared/custom_widget/active_icon.dart';
import 'package:tech_talk/ui/views/code_view/code_view.dart';
import 'package:tech_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class CommentCard extends GetView {
  final CommentModel comment;
  final bool? ischild;
  final bool? isReply;
  final VoidCallback likeCallback;
  final VoidCallback dislikeCallback;
  final VoidCallback replies;

  final bool isPostOwner;
  final VoidCallback? onPinToggle;

  final bool isCommentOwner;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CommentCard({
    required this.likeCallback,
    required this.dislikeCallback,
    required this.replies,
    super.key,
    required this.comment,
    this.ischild = false,
    this.isReply = true,
    this.isPostOwner = false,
    this.onPinToggle,
    this.isCommentOwner = false,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPinned = comment.isHighlighted;

    return Container(
      padding: EdgeInsets.all(Responsive.wp(0.03)),
      margin: EdgeInsets.all(Responsive.wp(0.02)),
      decoration: BoxDecoration(
        color: isPinned
            ? Appcolor.accent.withAlpha(25)
            : Appcolor.dark_20.withAlpha(250),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isPinned
              ? Appcolor.accent.withAlpha(180)
              : Appcolor.accent.withAlpha(50),
          width: isPinned ? 1.4 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPinned)
            Padding(
              padding: EdgeInsets.only(bottom: Responsive.hp(0.012)),
              child: Row(
                children: [
                  Icon(
                    Icons.push_pin_rounded,
                    size: Responsive.sp(0.036),
                    color: Appcolor.accent,
                  ),
                  SizedBox(width: Responsive.wp(0.012)),
                  CustomText(
                    text: "Pinned Comment",
                    styleType: TextStyleType.SMALL,
                    fontWeight: FontWeight.w600,
                    textColor: Appcolor.accent,
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: UsetInfoHeader(
                  nameProfile: comment.userName,
                  date: comment.createdAt,
                  imageProfile: comment.avatarUrl,
                  moveToUserProfile: () {},
                ),
              ),
              _buildOwnerActions(context, isPinned),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.all(Responsive.wp(0.02)),
            child: buildCommentText(comment.body),
          ),

          if (comment.code != null && comment.code!.trim().isNotEmpty)
            CodeView(
              mode: CodeViewMode.view,
              isdialog: false,
              code: comment.code,
            ),

          Row(
            children: [
              if (isReply != false) ...[
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: replies,
                  icon: Icon(Icons.reply),
                  color: Appcolor.accent.withAlpha(150),
                  iconSize: Responsive.sp(0.07),
                ),
                CustomText(
                  text: comment.hasChildrens ? "replyies" : "",
                  styleType: TextStyleType.SMALL,
                  textColor: Appcolor.white,
                ),
              ],
              Spacer(),
              ActiveIcon(
                icon: Icons.thumb_up_alt_outlined,
                iconIsActive: Icons.thumb_up,
                numOfInteractors: formatEngagement(
                  int.parse(comment.likesCount),
                ),
                color: Appcolor.white.withAlpha(200),
                isActive: comment.isLikedByUser,
                function: likeCallback,
              ),
              SizedBox(width: Responsive.wp(0.02)),
              ActiveIcon(
                icon: Icons.thumb_down_alt_outlined,
                iconIsActive: Icons.thumb_down,
                numOfInteractors: formatEngagement(
                  int.parse(comment.dislikesCount),
                ),
                color: Appcolor.white.withAlpha(200),
                isActive: comment.isDislikedByUser,
                function: dislikeCallback,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerActions(BuildContext context, bool isPinned) {
    // صاحب البوست + صاحب التعليق بنفس الوقت → قائمة واحدة (تعديل/حذف/تثبيت)
    if (isPostOwner && isCommentOwner) {
      return _CommentOptionsMenu(
        isPinned: isPinned,
        onPinToggle: onPinToggle,
        onEdit: onEdit,
        onDelete: () => _confirmDelete(context),
      );
    }

    // صاحب التعليق بس → أيقونتين تعديل وحذف
    if (isCommentOwner) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: onEdit,
            icon: Icon(Icons.edit_outlined),
            color: Appcolor.white.withAlpha(150),
            iconSize: Responsive.sp(0.05),
            tooltip: "Edit comment",
          ),
          SizedBox(width: Responsive.wp(0.02)),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => _confirmDelete(context),
            icon: Icon(Icons.delete_outline_rounded),
            color: const Color.fromARGB(255, 224, 92, 92),
            iconSize: Responsive.sp(0.05),
            tooltip: "Delete comment",
          ),
        ],
      );
    }

    if (isPostOwner) {
      return IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onPinToggle,
        icon: Icon(isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined),
        color: isPinned ? Appcolor.accent : Appcolor.white.withAlpha(150),
        iconSize: Responsive.sp(0.055),
        tooltip: isPinned ? "Unpin comment" : "Pin comment",
      );
    }

    return const SizedBox.shrink();
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: Responsive.wp(0.06)),
        child: Container(
          padding: EdgeInsets.all(Responsive.wp(0.055)),
          decoration: BoxDecoration(
            color: Appcolor.dark_20.withAlpha(250),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Appcolor.accent.withAlpha(50)),
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
                decoration: BoxDecoration(
                  color: const Color(0x1FE0895C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: const Color.fromARGB(255, 224, 92, 92),
                  size: 32,
                ),
              ),
              SizedBox(height: Responsive.hp(0.02)),
              CustomText(
                text: "Delete this comment?",
                styleType: TextStyleType.CUSTOM,
                fontSize: Responsive.sp(0.05),
                fontWeight: FontWeight.w700,
                textColor: Appcolor.white,
              ),
              SizedBox(height: Responsive.hp(0.01)),
              CustomText(
                text: "This action is permanent and cannot be undone.",
                styleType: TextStyleType.BODY,
                textColor: Appcolor.white.withAlpha(180),
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
                          border: Border.all(
                            color: Appcolor.accent.withAlpha(60),
                          ),
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
                          color: const Color.fromARGB(255, 224, 92, 92),
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

enum _CommentOption { edit, delete, pin }

class _CommentOptionsMenu extends StatelessWidget {
  final bool isPinned;
  final VoidCallback? onPinToggle;
  final VoidCallback? onEdit;
  final VoidCallback onDelete;

  const _CommentOptionsMenu({
    required this.isPinned,
    required this.onDelete,
    this.onPinToggle,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_CommentOption>(
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.more_horiz_rounded,
        color: Appcolor.white.withAlpha(150),
      ),
      color: Appcolor.dark_20.withAlpha(250),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.35),
      surfaceTintColor: Appcolor.gray_95,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Appcolor.accent.withAlpha(50)),
      ),
      constraints: BoxConstraints(minWidth: Responsive.wp(0.46)),
      offset: Offset(0, Responsive.hp(0.045)),
      popUpAnimationStyle: AnimationStyle(
        curve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 200),
        reverseCurve: Curves.easeInCubic,
        reverseDuration: const Duration(milliseconds: 140),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _CommentOption.pin,
          height: Responsive.hp(0.06),
          child: _MenuRow(
            icon: isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined,
            iconBg: Appcolor.accent.withAlpha(35),
            iconColor: Appcolor.accent,
            label: isPinned ? "Unpin" : "Pin",
          ),
        ),
        _menuDivider(),
        PopupMenuItem(
          value: _CommentOption.edit,
          height: Responsive.hp(0.06),
          child: _MenuRow(
            icon: Icons.edit_outlined,
            iconBg: Appcolor.dark_20,
            iconColor: Appcolor.white,
            label: "Edit",
          ),
        ),
        _menuDivider(),
        PopupMenuItem(
          value: _CommentOption.delete,
          height: Responsive.hp(0.06),
          child: _MenuRow(
            icon: Icons.delete_outline_rounded,
            iconBg: const Color(0x1FE0895C),
            iconColor: const Color.fromARGB(255, 224, 92, 92),
            label: "Delete",
            labelColor: const Color.fromARGB(255, 224, 92, 92),
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case _CommentOption.pin:
            onPinToggle?.call();
            break;
          case _CommentOption.edit:
            onEdit?.call();
            break;
          case _CommentOption.delete:
            onDelete();
            break;
        }
      },
    );
  }

  PopupMenuEntry<_CommentOption> _menuDivider() {
    return PopupMenuItem<_CommentOption>(
      enabled: false,
      height: 1,
      padding: EdgeInsets.zero,
      child: Container(height: 1, color: Appcolor.accent.withAlpha(30)),
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

String formatEngagement(int? value) {
  final number = value ?? 0;

  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}M';
  }

  if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(number >= 10000 ? 0 : 1)}k';
  }

  return number.toString();
}

Widget buildCommentText(String text) {
  final regex = RegExp(r'@\w+');

  final matches = regex.allMatches(text);

  if (matches.isEmpty) {
    return Text(
      text,
      style: TextStyle(
        color: Appcolor.white.withAlpha(200),
        fontSize: Responsive.sp(0.04),
      ),
    );
  }

  final spans = <TextSpan>[];
  int currentIndex = 0;

  for (final match in matches) {
    if (match.start > currentIndex) {
      spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
    }

    spans.add(
      TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(color: Appcolor.accent, fontWeight: FontWeight.bold),
      ),
    );

    currentIndex = match.end;
  }

  if (currentIndex < text.length) {
    spans.add(TextSpan(text: text.substring(currentIndex)));
  }

  return RichText(
    text: TextSpan(
      style: TextStyle(
        color: Appcolor.white.withAlpha(200),
        fontSize: Responsive.sp(0.04),
      ),
      children: spans,
    ),
  );
}
