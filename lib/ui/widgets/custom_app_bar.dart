import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  String titleText;
  bool automaticallyImplyLeading;
  bool showBorder;

  CustomAppBar({this.titleText, this.automaticallyImplyLeading = true, this.showBorder = true});

  @override
  Size get preferredSize {
    return new Size.fromHeight(57.5);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,

      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      shape: showBorder
          ? Border(
              bottom: BorderSide(
                color: Color(0xFFC4C4C4),
                width: 1,
              ),
            )
          : null,
      title: Container(
        width: 100,
        child: Text(
          titleText,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      centerTitle: true,
    );
  }
}
