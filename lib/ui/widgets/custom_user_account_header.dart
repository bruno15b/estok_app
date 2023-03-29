import 'package:flutter/material.dart';

class CustomUserAccountHeader extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final String circleAvatarImage;
  final String backgroundImage;
  final double backgroundHeight;
  final TextStyle textStyleName;
  final TextStyle textStyleEmail;
  final EdgeInsetsGeometry padding;
  final double spaceTextAvatar;

  CustomUserAccountHeader({
    @required this.accountName,
    @required this.accountEmail,
    @required this.circleAvatarImage,
    this.backgroundImage,
    this.backgroundHeight,
    this.padding,
    this.spaceTextAvatar,
    this.textStyleEmail,
    this.textStyleName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: backgroundHeight ?? 200,
      child: Container(
        padding: padding ?? EdgeInsets.only(top: 41, left: 29),
        decoration: backgroundImage != null
            ? BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.transparent.withOpacity(0.3),
                BlendMode.colorBurn),
          ),
        )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(circleAvatarImage),
              radius: 40,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: spaceTextAvatar ?? 19,
            ),
            Text(
              accountName,
              style: textStyleName ?? TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            Text(
              accountEmail,
              style: textStyleEmail ?? TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
