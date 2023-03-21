import 'package:flutter/material.dart';

class CustomUserAccountDrawerHeader extends StatelessWidget {

  final String accountName;
  final String accountEmail;
  final String circleAvatarImage;
  final String backgroundImage;
  final double backgroundHeight;

  CustomUserAccountDrawerHeader({
    @required this.accountName,
    @required this.accountEmail,
    this.circleAvatarImage,
    this.backgroundImage,
    this.backgroundHeight
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: backgroundHeight ?? 200,
      child: Container(
        padding: EdgeInsets.only(top: 41, left: 29),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage( backgroundImage ?? ""),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.transparent.withOpacity(0.3), BlendMode.colorBurn),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(circleAvatarImage ?? ""),
              radius: 40,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: 19,
            ),
            Text(
              accountName,
              style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            Text(
              accountEmail,
              style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
