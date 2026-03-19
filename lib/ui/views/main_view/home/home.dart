import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Appcolor.black_08,);
  }
}