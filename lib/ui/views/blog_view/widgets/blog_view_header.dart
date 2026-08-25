import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/controllers/blog_view_controller.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:tech_talk/ui/shared/shared_widget/image_url_helper.dart';

class BlogViewHeader extends GetView<BlogViewController> {
  final String heroImage;
  final String title;
  final String subTitle;
  final bool isViewed;

  const BlogViewHeader({
    super.key,
    required this.heroImage,
    required this.title,
    required this.subTitle,
    required this.isViewed,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedUrl = resolveImageUrl(heroImage);

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: Responsive.wp(0.04),
        top: Responsive.hp(0.015),
        end: Responsive.wp(0.04),
        bottom: Responsive.hp(0.01),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: Responsive.hp(0.27),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Appcolor.panelEdge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // IMAGE
                  _HeroImage(url: resolvedUrl),

                  // DARK OVERLAY
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Appcolor.bg.withOpacity(0.25),
                          Appcolor.bg.withOpacity(0.85),
                        ],
                      ),
                    ),
                  ),

                  // TOP TAG
                  Positioned(
                    top: Responsive.hp(0.018),
                    left: Responsive.wp(0.035),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.wp(0.025),
                        vertical: Responsive.hp(0.007),
                      ),
                      decoration: BoxDecoration(
                        color: Appcolor.bg.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isViewed
                              ? Appcolor.success.withOpacity(0.5)
                              : Appcolor.accent.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isViewed
                                ? Icons.check_circle_rounded
                                : Icons.article_outlined,
                            color: isViewed
                                ? Appcolor.success
                                : Appcolor.accent,
                            size: Responsive.sp(0.04),
                          ),
                          SizedBox(width: Responsive.wp(0.012)),
                          Text(
                            isViewed ? 'VIEWED' : 'BLOG',
                            style: TextStyle(
                              color: Appcolor.white,
                              fontSize: Responsive.sp(0.028),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // BOTTOM TEXT
                  Positioned(
                    left: Responsive.wp(0.035),
                    right: Responsive.wp(0.035),
                    bottom: Responsive.hp(0.018),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          title,
                          maxLines: 3,
                          minFontSize: 18,
                          maxFontSize: 30,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            color: Appcolor.white,
                            fontSize: Responsive.sp(0.065),
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                        SizedBox(height: Responsive.hp(0.005)),
                        AutoSizeText(
                          subTitle,
                          maxLines: 2,
                          minFontSize: 12,
                          maxFontSize: 17,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            color: Appcolor.white.withOpacity(0.7),
                            fontSize: Responsive.sp(0.035),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: Responsive.hp(0.014)),

          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(height: 3, color: Appcolor.panelEdge),
                  FractionallySizedBox(
                    widthFactor: controller.scrollProgress.value,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Appcolor.accent.withOpacity(0.6),
                            Appcolor.accent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return _fallback();
    }

    return Image.network(
      url!,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Appcolor.panel,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: Appcolor.accent,
            strokeWidth: 2,
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => _fallback(),
    );
  }

  Widget _fallback() {
    return Container(
      color: Appcolor.panel,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_rounded,
        color: Appcolor.panelEdge,
        size: Responsive.sp(0.09),
      ),
    );
  }
}
