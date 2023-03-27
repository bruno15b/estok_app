import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/stock_add_page.dart';
import 'package:estok_app/ui/tile/product_tile.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class StockShowPage extends StatefulWidget {
  final Stock _stock;
  final Color color;

  StockShowPage(this._stock, this.color);

  @override
  State<StockShowPage> createState() => _StockShowPageState();
}

class _StockShowPageState extends State<StockShowPage> {
  void _reload() async {
    ProductModel.of(context).fetchProducts(context, widget._stock.id);
  }

  @override
  void initState() {
    super.initState();
    ProductModel.of(context).fetchProducts(context, widget._stock.id);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(widget._stock.stockDescription),
      body: Column(
        children: [
          Container(
            height: 170,
            margin: EdgeInsets.fromLTRB(20, 23, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tipo: ${widget._stock.typeOfStock.toUpperCase()}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Entrada em: ${StockModel.of(context).formatDateToString(widget._stock.enterDate)}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Validade: ${StockModel.of(context).formatDateToString(widget._stock.validityDate)}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Valor Total: R\$ 5.550,50 ",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${widget._stock.totalProductQuantity}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).accentColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: Text(
                            widget._stock.stockStatus,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: widget.color,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return StockAddPage(
                                    stock: widget._stock,
                                  );
                                },
                              ),
                            );
                          }),
                      IconButton(icon: Icon(Icons.delete), onPressed: () {
                        StockModel.of(context).deleteStock(widget._stock,onSuccess: () {
                          Message.onSuccess(
                              scaffoldKey: _scaffoldKey,
                              message: "Estoque deletado",
                              seconds: 2,
                              onPop: (value) {
                                Navigator.of(context).pop();
                              });
                          return;
                        }, onFail: (string) {
                          Message.onFail(
                            scaffoldKey: _scaffoldKey,
                            message: "Erro ao deletar Estoque",
                            seconds: 2,
                          );
                          return;
                        });
                      })
                    ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Produtos",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 1,
                  width: 223,
                  color: Color(0xFFBEBBBB),
                )
              ],
            ),
          ),
          ScopedModelDescendant<ProductModel>(
            builder: (context, child, productModel) {
              return FutureBuilder(
                future: productModel.futureProductList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Message.alert(
                          "Não foi possivel obter os dados necessários",
                          onPressed: _reload,
                          color: Theme.of(context).primaryColor);
                    case ConnectionState.waiting:
                      return Message.loading(context);
                    default:
                      if (snapshot.hasError) {
                        print('Snapshot has error: ${snapshot.error}');
                        return Message.alert(
                            "Não foi possivel obter os dados do servidor, recarregue a pagina!",
                            onPressed: _reload,
                            color: Theme.of(context).primaryColor);
                      } else if (!snapshot.hasData) {
                        return Message.alert(
                            "Não foi possivel obter os Produtos, recarregue a pagina!",
                            onPressed: _reload,
                            color: Theme.of(context).primaryColor);
                      } else if (snapshot.data.isEmpty) {
                        return Message.alert("Nenhum Produto Cadastrado",
                            onPressed: _reload,
                            color: Theme.of(context).primaryColor);
                      } else {
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _reload();
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 11),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductTile(
                                  snapshot.data[index],
                                );
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
    );
  }
}
