import 'package:estok_app/entities/history.dart';
import 'package:estok_app/models/history_model.dart';
import 'package:estok_app/ui/tiles/history_tile.dart';
import 'package:estok_app/ui/widgets/custom_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    HistoryModel.of(context).getAllHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<HistoryModel>(
        builder: (context, child, historyModel) {
          return Center(
            child: CustomFutureBuilder(
              futureList: historyModel.historyListFuture,
              onRefresh: _reload,
              padding: EdgeInsets.only(left: 5, right: 5, top: 40, bottom: 90),
              itemBuilder: (BuildContext context, History history) {
                return HistoryTile(history);
              },
            ),
          );
        },
      ),
    );
  }
}
