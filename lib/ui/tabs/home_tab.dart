import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/entities/user.dart';

import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:estok_app/ui/tile/stock_tile.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class HomeTab extends StatefulWidget {

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() async{
    StockModel.of(context).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<StockModel>(builder: (context, child, stockModel) {
      return FutureBuilder(
          future: stockModel.futureStockList,
          builder: (BuildContext context, AsyncSnapshot<List<Stock>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Message.alert(
                    "Não foi possivel obter os dados necessários");
              case ConnectionState.waiting:
                return Message.loading(context);
              default:
                if (snapshot.hasError) {
                  print('Snapshot has error: ${snapshot.error}');
                  return Message.alert(
                      "Não foi possivel obter os dados do servidor");
                } else if (!snapshot.hasData) {
                  return Message.alert(
                      "Não foi possivel obter os dados de estoque");
                } else if (snapshot.data.isEmpty) {
                  return Message.alert("Nenhum carro encontrado",
                      fontSize: 16);
                } else {
                  return RefreshIndicator(
                    onRefresh: () async{
                     _reload();
                    },
                    child: ListView.builder(
                        padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StockTile(snapshot.data[index]);
                        }),
                  );
                }
            }
          });
    });
  }
}
