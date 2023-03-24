import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {

  String titleText;

  CustomAppBar(this.titleText);

  @override
  Size get preferredSize {
    return new Size.fromHeight(56.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color: Color(0xFFC4C4C4),
          width: 1,
        ),
      ),
      title: Text(titleText),
      centerTitle: true,
    );
  }
}
