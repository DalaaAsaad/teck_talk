import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/custom_widget/custom_text.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';
import 'package:teck_talk/ui/shared/shared_widget/utilies.dart';

class TableOfContentsCard extends StatelessWidget {
  final List<String> tableOfContents;

  const TableOfContentsCard({super.key, required this.tableOfContents});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth(22),
        vertical: screenWidth(24),
      ),
      decoration: BoxDecoration(
        color: Appcolor.Black_05,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Appcolor.dark_20.withAlpha(110)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tableOfContents
            .map(
              (section) => Padding(
                padding: EdgeInsets.only(bottom: screenWidth(28)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenWidth(48)),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Appcolor.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth(34)),
                    Expanded(
                      child: CustomText(
                        text: section,
                        styleType: TextStyleType.CUSTOM,
                        textColor: Appcolor.white,
                        fontSize: screenWidth(28),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
