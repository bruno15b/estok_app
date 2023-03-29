import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
 final Widget pageRoute;

  CustomFloatingActionButton(
      this.pageRoute
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 5),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return pageRoute;
              },
            ),
          );
        },
      ),
    );
  }
}
