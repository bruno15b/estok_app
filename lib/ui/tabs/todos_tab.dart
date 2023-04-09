import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/tiles/stock_tile.dart';
import 'package:estok_app/ui/widgets/custom_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TodosTab extends StatelessWidget {
  final String category;

  TodosTab(this.category);

  @override
  Widget build(BuildContext context) {
    void _reload() {
      StockModel.of(context).fetchAllStocks();
    }

    return ScopedModelDescendant<StockModel>(
      builder: (context, child, stockModel) {
        return CustomFutureBuilder(
          futureList: stockModel.futureStockList,
          onRefresh: _reload,
          filter: stockModel.filterStockByStatus,
          filterCategory: category,
          itemBuilder: (BuildContext context, Stock stock) {
            return StockTile(stock);
          },
        );
      },
    );
  }
}
