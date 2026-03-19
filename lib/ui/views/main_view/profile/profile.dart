import 'package:flutter/material.dart';
import 'package:teck_talk/ui/shared/shared_widget/appcolor.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Appcolor.black_08,);
  }
}