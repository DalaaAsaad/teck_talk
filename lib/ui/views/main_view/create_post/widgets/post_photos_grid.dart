import 'package:flutter/material.dart';
import 'package:tech_talk/core/data/responses/update_post_response.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class PostPhotosGrid extends StatelessWidget {
  final List<PostPhoto> photos;
  final Set<String> deletingPhotoIds;
  final bool isUploading;
  final void Function(PostPhoto photo) onRemove;
  final VoidCallback onAdd;

  const PostPhotosGrid({
    super.key,
    required this.photos,
    required this.deletingPhotoIds,
    required this.isUploading,
    required this.onRemove,
    required this.onAdd,
  });

  static double _tileSize() {
    return (Responsive.wp(1) -
            Responsive.wp(0.045) * 2 -
            Responsive.wp(0.08) * 2 -
            Responsive.wp(0.03)) /
        2;
  }

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return _EmptyUploadArea(isUploading: isUploading, onTap: onAdd);
    }

    return Wrap(
      spacing: Responsive.wp(0.03),
      runSpacing: Responsive.wp(0.03),
      children: [
        for (final photo in photos)
          _PhotoTile(
            url: photo.url,
            isDeleting: deletingPhotoIds.contains(photo.id.toString()),
            onRemove: () => onRemove(photo),
          ),
        _AddPhotoTile(isUploading: isUploading, onTap: onAdd),
      ],
    );
  }
}

class _EmptyUploadArea extends StatelessWidget {
  final bool isUploading;
  final VoidCallback onTap;

  const _EmptyUploadArea({required this.isUploading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isUploading ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        height: Responsive.hp(0.16),
        decoration: BoxDecoration(
          color: Appcolor.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Appcolor.panelEdge),
        ),
        alignment: Alignment.center,
        child: isUploading
            ? SizedBox(
                width: Responsive.wp(0.06),
                height: Responsive.wp(0.06),
                child: CircularProgressIndicator(
                  color: Appcolor.accent,
                  strokeWidth: 2,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: Responsive.wp(0.12),
                    height: Responsive.wp(0.12),
                    decoration: BoxDecoration(
                      color: Appcolor.accentDim,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: Appcolor.accent,
                      size: Responsive.sp(0.055),
                    ),
                  ),
                  SizedBox(height: Responsive.hp(0.012)),
                  CustomText(
                    text: 'Add photos',
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.white,
                    fontSize: Responsive.sp(0.037),
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: Responsive.hp(0.003)),
                  CustomText(
                    text: 'Tap to upload from gallery',
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.muted,
                    fontSize: Responsive.sp(0.031),
                  ),
                ],
              ),
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  final String url;
  final bool isDeleting;
  final VoidCallback onRemove;

  const _PhotoTile({
    required this.url,
    required this.isDeleting,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final size = PostPhotosGrid._tileSize();
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              url,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Appcolor.panel,
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_not_supported_rounded,
                  color: Appcolor.muted,
                  size: Responsive.sp(0.08),
                ),
              ),
            ),
          ),
          if (isDeleting)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  width: Responsive.wp(0.06),
                  height: Responsive.wp(0.06),
                  child: const CircularProgressIndicator(
                    color: Appcolor.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            )
          else
            Positioned(
              top: -8,
              right: -8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: Responsive.wp(0.08),
                    height: Responsive.wp(0.08),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Appcolor.danger,
                      shape: BoxShape.circle,
                      border: Border.all(color: Appcolor.bg, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Appcolor.white,
                      size: Responsive.sp(0.04),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  final bool isUploading;
  final VoidCallback onTap;

  const _AddPhotoTile({required this.isUploading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = PostPhotosGrid._tileSize();
    return InkWell(
      onTap: isUploading ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Appcolor.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Appcolor.panelEdge),
        ),
        child: isUploading
            ? SizedBox(
                width: Responsive.wp(0.055),
                height: Responsive.wp(0.055),
                child: CircularProgressIndicator(
                  color: Appcolor.accent,
                  strokeWidth: 2,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Appcolor.accent,
                    size: Responsive.sp(0.07),
                  ),
                  SizedBox(height: Responsive.hp(0.006)),
                  CustomText(
                    text: 'Add more',
                    styleType: TextStyleType.CUSTOM,
                    textColor: Appcolor.accent,
                    fontSize: Responsive.sp(0.03),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
      ),
    );
  }
}
