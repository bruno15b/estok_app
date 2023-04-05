import 'package:estok_app/entities/product.dart';
import 'package:estok_app/models/history_model.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/product_add_page.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  final void Function(bool, Product) message;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ProductTile(this._product, this.message, this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    void updateStocksProductsWithServer(Product product) async {
      Message.alertDialogLoading(context);
      try {
        await ProductModel.of(context).sumProductsTotalValue();
        double stockTotal = await ProductModel.of(context).sumProductsTotalQuantity();
        await StockModel.of(context).updateStockTotalProductQuantity(stockTotal);
        StockModel.of(context).updateOpenStockStatus();
        await Future.delayed(Duration(milliseconds: 500));
        await StockModel.of(context).fetchAllStocks();
        await Future.delayed(Duration(milliseconds: 500));
      } catch (e) {
        print(e);
      } finally {
        Navigator.of(context).pop();
        await ProductModel.of(context).fetchAllProducts(product.stockId);
      }
    }

    return InkWell(
      onTap: () {
        ProductModel.of(context).productUnitQuantity = null;
        Message.alertDialogConfirm(
          context,
          textOkButton: "Alterar ",
          textNoButton: "Cancelar",
          title: _product.productName,
          widget: ScopedModelDescendant<ProductModel>(
            builder: (context, snapshot, productModel) {
              if (productModel.productUnitQuantity == null) {
                productModel.productUnitQuantity = _product.productQuantity;
              }
              return Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => productModel.updateUnitaryProductQuantity("remove"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${productModel.productUnitQuantity}",
                      style: TextStyle(fontSize: 24, color: Color(0xFF949191), fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => productModel.updateUnitaryProductQuantity("add"),
                    )
                  ],
                ),
              );
            },
          ),
          onPressedOkButton: () async {
            Navigator.of(context).pop();
            _product.productQuantity = ProductModel.of(context).productUnitQuantity;

            await ProductModel.of(context).updateProduct(
              _product,
              onSuccess: () {
                Message.onSuccess(scaffoldKey: scaffoldKey, message: "Quantidade atualizada com sucesso!",onPop: (_){
                  updateStocksProductsWithServer(_product);
                  HistoryModel.of(context).saveHistoryOnUpdate(product: _product);
                });
                return;
              },
              onFail: (string) {
                Message.onFail(scaffoldKey: scaffoldKey, message: "Falha ao atualizar quantidade!");
                return;
              },
            );

          },
          onPressedNoButton: () {
            Navigator.of(context).pop();
          },
        );
      },
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          margin: EdgeInsets.only(bottom: 12),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        onDismissed: (direction) async {
          final bool success = await ProductModel.of(context).deleteProduct(_product);
          message(success, _product);
        },
        child: Column(
          children: [
            Container(
              height:132,
              width: double.infinity,
              padding: EdgeInsets.only(top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:3,
                    child: Container(
                      width: 85,
                      height: 74,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: _product.productImageUrl == null || _product.productImageUrl.isEmpty
                                ? AssetImage("assets/images/ic_camera.png")
                                : NetworkImage(_product.productImageUrl),
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _product.productName,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF555353),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: Text(
                                      _product.productDescription,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        color: Color(0xFF949191),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 65,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "R\$ ${_product.productItemPrice}",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 60,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "R\$ ${_product.productUnitaryPrice}",
                                        style: TextStyle(fontSize: 12,color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 28,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:EdgeInsets.only(left: 40),
                              child: Text(
                                "${_product.productQuantity}",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      ProductModel.of(context).shareWebsiteLink(_product);
                                    }),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return ProductAddPage.editProduct(
                                            product: _product,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
