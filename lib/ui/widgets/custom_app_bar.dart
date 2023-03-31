import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  String titleText;
  bool returnArrow;
  CustomAppBar({this.titleText, this.returnArrow = true});

  @override
  Size get preferredSize {
    return new Size.fromHeight(56.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: returnArrow,
      shape: Border(
        bottom: BorderSide(
          color: Color(0xFFC4C4C4),
          width: 1,
        ),
      ),
      title: Container(
        width: 100,
        child: Text(
          titleText,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
      centerTitle: true,
    );
  }
}
