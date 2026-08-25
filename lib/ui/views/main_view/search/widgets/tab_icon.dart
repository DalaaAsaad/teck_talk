import 'package:flutter/material.dart';

class TabIcon extends StatelessWidget {
  const TabIcon({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 34,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 14), const SizedBox(width: 5), Text(label)],
      ),
    );
  }
}
