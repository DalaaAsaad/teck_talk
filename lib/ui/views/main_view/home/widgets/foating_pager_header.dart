// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:tech_talk/controllers/homecontroller.dart';
// import 'package:tech_talk/core/utils/responsive.dart';
// import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

// class FoatingPagerHeader extends GetView<Homecontroller> {
//   const FoatingPagerHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tech_talk/controllers/homecontroller.dart';
// import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';
// import 'package:tech_talk/ui/shared/shared_widget/utilies.dart';
// import 'package:tech_talk/ui/views/main_view/home/widgets/pager_button.dart';

// class FloatingPagerHeader extends GetView<Homecontroller> {
//   const FloatingPagerHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsetsDirectional.fromSTEB(
//         screenWidth(25),
//         screenWidth(35),
//         screenWidth(25),
//         screenWidth(25),
//       ),
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth(35),
//           vertical: screenWidth(45),
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(28),
//           gradient: LinearGradient(
//             colors: [
//               Appcolor.white.withAlpha(90),
//               Appcolor.gray_95.withAlpha(100),
//               Appcolor.black_08.withAlpha(1),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Appcolor.gray_60.withAlpha(61),
//               blurRadius: 28,
//               offset: const Offset(0, 14),
//             ),
//           ],
//           border: Border.all(color: Appcolor.gray_95.withAlpha(20)),
//         ),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Positioned(
//               right: -18,
//               top: -20,
//               child: Container(
//                 width: screenWidth(5),
//                 height: screenWidth(5),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Appcolor.white.withAlpha(30),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: -14,
//               bottom: -16,
//               child: Container(
//                 width: screenWidth(7),
//                 height: screenWidth(7),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Appcolor.white.withAlpha(20),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Obx(
//                   () => PagerButton(
//                     icon: Icons.chevron_left_rounded,
//                     enabled:
//                         controller.currentPage.value > 1 &&
//                         !controller.isLoading.value,
//                     onTap: controller.previousPage,
//                   ),
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Obx(
//                       () => Text(
//                         'Page ${controller.currentPage.value}',
//                         style: TextStyle(
//                           color: Appcolor.white,
//                           fontSize: screenWidth(28),
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: screenWidth(120)),
//                   ],
//                 ),
//                 Obx(
//                   () => PagerButton(
//                     icon: Icons.chevron_right_rounded,
//                     enabled: !controller.isLoading.value,
//                     onTap: controller.nextPage,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
