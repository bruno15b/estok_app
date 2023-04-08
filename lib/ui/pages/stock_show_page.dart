import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/history_model.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/product_add_page.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/tiles/product_tile.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_floating_action_button.dart';
import 'package:estok_app/ui/widgets/custom_future_builder.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:estok_app/utils/server_sync_util.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StockShowPage extends StatelessWidget {
  final Stock _stock;

  StockShowPage(this._stock);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _reload() async {
      try {
        await StockModel.of(context).fetchAllStocks();
        await Future.delayed(Duration(milliseconds: 500));
        await ProductModel.of(context).fetchAllProducts(_stock.id);
        await ProductModel.of(context).sumProductsTotalValue();
      } catch (e) {
        print(e);
      }
    }

    deleteProductResponseFn(bool deleteProductResponse, Product product) {
      if (deleteProductResponse) {
        return Message.onSuccess(
            scaffoldKey: _scaffoldKey,
            message: "Produto deletado",
            seconds: 2,
            onPop: (_) async {
              await ProductModel.of(context).fetchAllProducts(product.stockId);
              await ServerSyncUtil.updateStocksProductsWithServer(context, product);
              HistoryModel.of(context).saveHistoryOnDelete(product: product);
            });
      } else {
        return Message.onFail(
            scaffoldKey: _scaffoldKey,
            message: "Falha ao deletar o produto",
            seconds: 2,
            onPop: (_) {
              ProductModel.of(context).fetchAllProducts(product.stockId);
            });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(titleText: _stock.stockDescription),
      body: Column(
        children: [
          Container(
            height: 165,
            margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScopedModelDescendant<ProductModel>(builder: (context, snapshot, productModel) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tipo: ${_stock.typeOfStock.toUpperCase()}",
                        style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      Text(
                        "Entrada em: ${StockModel.of(context).formatDateToString(_stock.enterDate)}",
                        style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      Text(
                        "Validade: ${StockModel.of(context).formatDateToString(_stock.validityDate)}",
                        style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      Text(
                        "Valor Total: ${productModel.productsTotalValue} ",
                        style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }),
                ScopedModelDescendant<StockModel>(
                  builder: (context, snapshot, stockModel) {
                    return Column(
                      children: [
                        Text(
                          "${_stock.stockTotalProductQuantity?.round()}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.bodyText2.color),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 10),
                          child: SizedBox(
                            width: 80,
                            child: Text(
                              "${_stock.stockStatus}",
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: stockModel.selectedStockStatusColor,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            constraints: BoxConstraints(maxHeight: 36),
                            icon: Icon(
                              Icons.edit,
                              size: 22,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return StockAddPage(
                                      stock: _stock,
                                    );
                                  },
                                ),
                              );
                            }),
                        IconButton(
                          constraints: BoxConstraints(maxHeight: 36),
                          icon: Icon(
                            Icons.delete,
                            size: 22,
                          ),
                          onPressed: () async {
                            Message.alertDialogConfirm(
                              context,
                              title: "Deseja excluir o estoque?",
                              subtitle:
                                  "A exclusão ira deletar permanentemente todos os dados de produto que essse estoque possui",
                              onPressedNoButton: () {
                                Navigator.of(context).pop();
                              },
                              onPressedOkButton: () async {
                                await StockModel.of(context).deleteStock(
                                  _stock,
                                  onSuccess: () {
                                    Message.onSuccess(
                                        scaffoldKey: _scaffoldKey,
                                        message: "Estoque deletado",
                                        seconds: 2,
                                        onPop: (value) {
                                          StockModel.of(context).fetchAllStocks();
                                          HistoryModel.of(context).saveHistoryOnDelete(stock: _stock);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        });
                                    return;
                                  },
                                  onFail: (string) {
                                    Message.onFail(
                                      scaffoldKey: _scaffoldKey,
                                      message: "Erro ao deletar Estoque",
                                      seconds: 2,
                                    );

                                    return;
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Produtos",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Divider(
                    height: 4,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ScopedModelDescendant<ProductModel>(
              builder: (context, child, productModel) {
                return CustomFutureBuilder(
                  futureList: productModel.futureProductList,
                  onRefresh: _reload,
                  padding: EdgeInsets.only(left: 11, right: 11, top: 18, bottom: 90),
                  itemBuilder: (BuildContext context, Product product) {
                    return ProductTile(product, deleteProductResponseFn, _scaffoldKey);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        ProductAddPage.newProduct(
          stock: _stock,
        ),
      ),
    );
  }
}
