import 'package:flutter/material.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/custom_widget/user-info_header.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/image_url_helper.dart';

class BlogCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? coverImageUrl;
  final List<String> tags;

  final String authorName;
  final String authorAvatarUrl;
  final dynamic createdAt;

  final VoidCallback? onReadMore;

  final bool dense;

  const BlogCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.createdAt,
    this.coverImageUrl,
    this.tags = const [],
    this.onReadMore,
    this.dense = false,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final resolvedCoverUrl = resolveImageUrl(widget.coverImageUrl);

    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        margin: EdgeInsetsDirectional.only(
          start: Responsive.wp(widget.dense ? 0.03 : 0.045),
          end: Responsive.wp(widget.dense ? 0.03 : 0.02),
          top: Responsive.hp(widget.dense ? 0.006 : 0.01),
          bottom: Responsive.hp(widget.dense ? 0.006 : 0.01),
        ),

        transform: Matrix4.translationValues(0, isSelected ? -4 : 0, 0),

        decoration: BoxDecoration(
          color: Appcolor.panel,
          borderRadius: BorderRadius.circular(widget.dense ? 16 : 20),
          border: Border.all(
            color: isSelected
                ? Appcolor.accent
                : Appcolor.panelEdge.withOpacity(0.5),
            width: isSelected ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.26 : 0.12),
              blurRadius: isSelected ? 18 : 8,
              offset: Offset(0, isSelected ? 7 : 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Cover image with overlay tags ----
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(widget.dense ? 16 : 20),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: Responsive.hp(widget.dense ? 0.13 : 0.17),
                    width: double.infinity,
                    child: resolvedCoverUrl != null
                        ? Image.network(
                            resolvedCoverUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: Appcolor.panel,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: Responsive.wp(0.05),
                                  height: Responsive.wp(0.05),
                                  child: CircularProgressIndicator(
                                    color: Appcolor.accent,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/png/blog_image.png",
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            "assets/images/png/blog_image.png",
                            fit: BoxFit.cover,
                          ),
                  ),
                  // تدرج خفيف بالأسفل عشان الوسوم تنقرأ فوق أي صورة
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: Responsive.hp(0.06),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.tags.isNotEmpty)
                    Positioned(
                      left: Responsive.wp(0.025),
                      bottom: Responsive.hp(0.008),
                      right: Responsive.wp(0.025),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: widget.tags
                            .map((e) => _TagChip(text: e))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(
                Responsive.wp(0.03),
                Responsive.hp(widget.dense ? 0.008 : 0.01),
                Responsive.wp(0.03),
                Responsive.hp(widget.dense ? 0.008 : 0.01),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.title,
                    styleType: TextStyleType.CUSTOM,
                    fontSize: Responsive.sp(widget.dense ? 0.038 : 0.044),
                    fontWeight: FontWeight.w700,
                    textColor: Appcolor.white,
                  ),
                  CustomText(
                    text: widget.subtitle,
                    styleType: TextStyleType.CUSTOM,
                    fontSize: Responsive.sp(0.032),
                    fontWeight: FontWeight.w400,
                    textColor: Appcolor.muted,
                  ),

                  SizedBox(height: Responsive.hp(widget.dense ? 0.008 : 0.01)),
                  Container(
                    height: 1,
                    color: Appcolor.panelEdge.withOpacity(0.5),
                  ),
                  SizedBox(height: Responsive.hp(widget.dense ? 0.007 : 0.009)),

                  UsetInfoHeader(
                    nameProfile: widget.authorName,
                    date: widget.createdAt,
                    imageProfile: widget.authorAvatarUrl,
                    moveToUserProfile: () {},
                  ),

                  if (widget.onReadMore != null)
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: isSelected
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,

                      firstChild: const SizedBox(width: double.infinity),

                      secondChild: Padding(
                        padding: EdgeInsets.only(top: Responsive.hp(0.01)),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onReadMore,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.accent,
                              foregroundColor: Appcolor.white,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                vertical: Responsive.hp(0.009),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Read More",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Responsive.sp(0.033),
                                  ),
                                ),
                                SizedBox(width: Responsive.wp(0.012)),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: Responsive.sp(0.036),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
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
        horizontal: Responsive.wp(0.02),
        vertical: Responsive.hp(0.004),
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Appcolor.accent.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Appcolor.white,
          fontSize: Responsive.sp(0.027),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
