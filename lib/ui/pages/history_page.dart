import 'package:estok_app/entities/history.dart';
import 'package:estok_app/models/history_model.dart';
import 'package:estok_app/ui/tiles/history_tile.dart';
import 'package:estok_app/ui/widgets/message.dart';
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
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: ScopedModelDescendant<HistoryModel>(
          builder: (context, child, historyModel) {
            return FutureBuilder(
              future: historyModel.historyListFuture,
              builder: (BuildContext context, AsyncSnapshot<List<History>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Message.alert("Não foi possivel obter os dados necessários",
                        onPressed: _reload, color: Theme.of(context).primaryColor);
                  case ConnectionState.waiting:
                    return Message.loading(context);
                  default:
                    if (snapshot.hasError) {
                      return Message.alert("Não foi possivel obter os dados da database!",
                          onPressed: _reload, color: Theme.of(context).primaryColor);
                    } else if (!snapshot.hasData) {
                      return Message.alert("Não foi possivel obter os dados de histoórico, recarregue a pagina!",
                          onPressed: _reload, color: Theme.of(context).primaryColor);
                    } else if (snapshot.data.isEmpty) {
                      return Message.alert("Nenhum dado de histórico encontrado",
                          onPressed: _reload, color: Theme.of(context).primaryColor);
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          _reload();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 90),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return HistoryTile(snapshot.data[index]);
                          },
                        ),
                      );
                    }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
