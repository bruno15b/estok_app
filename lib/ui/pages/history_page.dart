import 'package:estok_app/ui/tiles/history_tile.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            HistoryTile(),
            HistoryTile(),
          ],
        ),
      ),
    );
  }
}
