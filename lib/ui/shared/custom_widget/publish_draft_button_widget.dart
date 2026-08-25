// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tech_talk/core/utils/responsive.dart';
// import 'package:tech_talk/ui/shared/custom_widget/custom_text.dart';
// import 'package:tech_talk/ui/shared/shared_widget/appcolor.dart';

// class PublishDraftButtonWidget extends StatelessWidget {
//   final VoidCallback onDraft;
//   final VoidCallback onPublish;
//   final Function(int) onSelected;
//   final RxInt selectedIndex;

//   const PublishDraftButtonWidget({
//     super.key,
//     required this.onDraft,
//     required this.onPublish,
//     required this.onSelected,
//     required this.selectedIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Row(
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: Responsive.hp(0.06),
//               child: OutlinedButton(
//                 onPressed: () {
//                   onSelected(0);
//                   onDraft();
//                 },
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: selectedIndex.value == 0
//                       ? Appcolor.accent
//                       : Colors.transparent,
//                   side: BorderSide(color: Appcolor.accent),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
//                   ),
//                 ),
//                 child: CustomText(
//                   text: "Save Draft",
//                   textColor: selectedIndex.value == 0
//                       ? Appcolor.black_08
//                       : Appcolor.white,
//                 ),
//               ),
//             ),
//           ),

//           SizedBox(width: Responsive.wp(0.03)),

//           Expanded(
//             child: SizedBox(
//               height: Responsive.hp(0.06),
//               child: ElevatedButton(
//                 onPressed: () {
//                   onSelected(1);
//                   onPublish();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: selectedIndex.value == 1
//                       ? Appcolor.accent
//                       : Appcolor.black_08,
//                   side: BorderSide(color: Appcolor.accent),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(Responsive.wp(0.02)),
//                   ),
//                 ),
//                 child: CustomText(
//                   text: "Publish",
//                   textColor: selectedIndex.value == 1
//                       ? Appcolor.black_08
//                       : Appcolor.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
