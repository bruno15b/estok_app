import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/tile/stock_tile.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class HomeTab extends StatefulWidget{

  final String category;
  HomeTab(this.category);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>{


  void _reload() async{
      StockModel.of(context).fetchStocks();
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
                    "Não foi possivel obter os dados necessários",onPressed:_reload,color: Theme.of(context).primaryColor);
              case ConnectionState.waiting:
                return Message.loading(context);
              default:
                if (snapshot.hasError) {
                  return Message.alert(
                      "Não foi possivel obter os dados do servidor, recarregue a pagina!",onPressed:_reload,color: Theme.of(context).primaryColor);
                } else if (!snapshot.hasData) {
                  return Message.alert(
                      "Não foi possivel obter os dados de estoque, recarregue a pagina!",onPressed:_reload,color: Theme.of(context).primaryColor);
                } else if (snapshot.data.isEmpty) {
                  return Message.alert("Nenhum estoque encontrado",
                      onPressed:_reload,color: Theme.of(context).primaryColor);
                } else {

                  List<Stock> filteredStocks = stockModel.filterStockByStatus(snapshot.data, widget.category);

                  return RefreshIndicator(
                    onRefresh: () async{
                     _reload();
                    },
                    child: ListView.builder(
                        padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                        itemCount:filteredStocks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return StockTile(filteredStocks[index]);
                        }),
                  );
                }
            }
          });
    });
  }
}
