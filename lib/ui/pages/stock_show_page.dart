import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/product_add_page.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/tiles/product_tile.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_floating_action_button.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StockShowPage extends StatelessWidget {
  final Stock _stock;
  final Color colorStockStatus;

  StockShowPage(this._stock, this.colorStockStatus);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _reload() async {
      try {
        await StockModel.of(context).fetchAllStocks();
        await ProductModel.of(context).fetchAllProducts(_stock.id);
        await Future.delayed(Duration(milliseconds: 500));
        await ProductModel.of(context).sumStockTotalPrice();
      } catch (e) {
        print(e);
      }
    }

    deleteProductResponse(bool response) async {

      if (response) {

        await ProductModel.of(context).fetchAllProducts(_stock.id);
        await ProductModel.of(context).sumStockTotalPrice();
        double totalStock = await ProductModel.of(context).sumStockTotalProductQuantity();
        await Future.delayed(Duration(milliseconds: 500));
        await StockModel.of(context).updateStockTotalProductQuantity(totalStock);
        StockModel.of(context).updateOpenStockStatus();
        await Future.delayed(Duration(milliseconds: 500));
        await StockModel.of(context).fetchAllStocks();

        return Message.onSuccess(
          scaffoldKey: _scaffoldKey,
          message: "Produto deletado",
          seconds: 2,
        );
      } else {
        return Message.onFail(
          scaffoldKey: _scaffoldKey,
          message: "Falha ao deletar o produto",
          seconds: 2,
        );
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
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        "Entrada em: ${StockModel.of(context).formatDateToString(_stock.enterDate)}",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        "Validade: ${StockModel.of(context).formatDateToString(_stock.validityDate)}",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        "Valor Total: ${productModel.totalValueOfStock} ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
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
                          padding: const EdgeInsets.only(top: 6, bottom: 10),
                          child: SizedBox(
                            width: 80,
                            child: Text(
                              "${stockModel.textStockStatusReplacer ?? _stock.stockStatus}",
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: stockModel.colorStockStatusReplacer ?? colorStockStatus,
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
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        });
                                    StockModel.of(context).fetchAllStocks();
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
                    color: Colors.black,
                    height: 4,
                  ),
                ),
              ],
            ),
          ),
          ScopedModelDescendant<ProductModel>(
            builder: (context, child, productModel) {
              return FutureBuilder(
                future: productModel.futureProductList,
                builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Message.alert("Não foi possivel obter os dados necessários",
                          onPressed: _reload, color: Theme.of(context).primaryColor);
                    case ConnectionState.waiting:
                      return Message.loading(context, height: 200);
                    default:
                      if (snapshot.hasError) {
                        print('Snapshot has error: ${snapshot.error}');
                        return Message.alert("Não foi possivel obter os dados do servidor, recarregue a pagina!",
                            onPressed: _reload, color: Theme.of(context).primaryColor);
                      } else if (!snapshot.hasData) {
                        return Message.alert("Não foi possivel obter os Produtos, recarregue a pagina!",
                            onPressed: _reload, color: Theme.of(context).primaryColor);
                      } else if (snapshot.data.isEmpty) {
                        return Message.alert("Nenhum Produto Cadastrado",
                            onPressed: _reload, color: Theme.of(context).primaryColor);
                      } else {
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _reload();
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 11, right: 11, top: 20, bottom: 90),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductTile(snapshot.data[index], deleteProductResponse);
                              },
                            ),
                          ),
                        );
                      }
                  }
                },
              );
            },
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
