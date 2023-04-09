import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Widget pageRoute;

  CustomFloatingActionButton(this.pageRoute);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return pageRoute;
              },
            ),
          );
        },
        elevation: 0,
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          size: 27,
        ),
      ),
    );
  }
}
