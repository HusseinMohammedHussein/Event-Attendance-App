import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize{
  final String title;

 const CustomAppBar(BuildContext context, {required this.title});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

 @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
    );
  }



  @override
  Widget get child => throw UnimplementedError();
}
