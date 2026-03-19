import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Appcolor.yellow_70);
  }
}
