import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_talk/app/my_routs.dart';
import 'package:tech_talk/controllers/blog_controller.dart';
import 'package:tech_talk/core/data/repository/shared_pref.dart';
import 'package:tech_talk/core/utils/responsive.dart';
import 'package:tech_talk/ui/shared/custom_widget/blog_card.dart';
import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

class blog extends GetView<BlogController> {
  const blog({super.key});

  bool get _isSenior {
    final badge = SharedPreferenceRepository().getBadge();
    return badge?.toLowerCase() == 'expert';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolor.black_08,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              Responsive.wp(0.045),
              Responsive.wp(0.04),
              Responsive.wp(0.045),
              Responsive.wp(0.015),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Blogs',
                  styleType: TextStyleType.CUSTOM,
                  textColor: Appcolor.white,
                  fontSize: Responsive.sp(0.045),
                  fontWeight: FontWeight.w600,
                ),

                if (_isSenior) const _NewBlogChip(),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: Appcolor.accent),
                );
              }

              if (controller.blogs.isEmpty) {
                return Center(
                  child: Text(
                    'No blogs found',
                    style: TextStyle(color: Appcolor.white),
                  ),
                );
              }

              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.blogs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: BlogCard(
                          title: controller.blogs[index].title,
                          subtitle: controller.blogs[index].subtitle,
                          coverImageUrl: controller.blogs[index].coverImageUrl,
                          tags: const [
                            "Flutter",
                            "Front End",
                          ], // أو من blog.tags إذا موجودة
                          authorName: controller.blogs[index].user.name,
                          authorAvatarUrl:
                              controller.blogs[index].user.avatarUrl,
                          createdAt: controller.blogs[index].createdAt,
                          onReadMore: () async {
                            final blogId = controller.blogs[index].id;

                            final result = await Get.toNamed(
                              AppRoutes.blogView,
                              arguments: blogId,
                            );

                            final isDeleted =
                                result == true || result == blogId;

                            if (!isDeleted) return;

                            controller.blogs.removeWhere(
                              (blog) => blog.id == blogId,
                            );

                            await controller.getBlogs();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: Responsive.hp(0.05)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// شبس صغير "New" أعلى يمين جنب عنوان الصفحة، يظهر بس للـ senior/expert.
class _NewBlogChip extends StatelessWidget {
  const _NewBlogChip();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final published = await Get.toNamed(AppRoutes.createBlog);
          if (published == true && Get.isRegistered<BlogController>()) {
            await Get.find<BlogController>().getBlogs();
          }
        },
        borderRadius: BorderRadius.circular(Responsive.wp(0.05)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.wp(0.03),
            vertical: Responsive.wp(0.018),
          ),
          decoration: BoxDecoration(
            color: Appcolor.accent,
            borderRadius: BorderRadius.circular(Responsive.wp(0.05)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit_rounded,
                color: Appcolor.white,
                size: Responsive.sp(0.032),
              ),
              SizedBox(width: Responsive.wp(0.015)),
              CustomText(
                text: 'New',
                styleType: TextStyleType.CUSTOM,
                textColor: Appcolor.white,
                fontSize: Responsive.sp(0.032),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
