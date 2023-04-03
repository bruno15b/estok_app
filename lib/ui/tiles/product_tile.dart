import 'package:estok_app/entities/product.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/product_add_page.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  final void Function(bool) message;

  ProductTile(this._product, this.message);

  @override
  Widget build(BuildContext context) {
    void updateStocksProductsWithServer(Product product) async {
      Message.alertDialogLoading(context);
      try {
        await ProductModel.of(context).sumProductsValue();
        await ProductModel.of(context).sumStockQuantity(product.stockId);
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
        ProductModel.of(context).singleProductQuantity = null;
        Message.alertDialogConfirm(
          context,
          textOkButton: "Alterar ",
          textNoButton: "Cancelar",
          title: _product.productName,
          widget: ScopedModelDescendant<ProductModel>(
            builder: (context, snapshot, productModel) {
              if (productModel.singleProductQuantity == null) {
                productModel.singleProductQuantity = _product.productQuantity;
              }
              return Container(
                padding: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => productModel.updateProductQuantity(false),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${productModel.singleProductQuantity}",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF949191),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => productModel.updateProductQuantity(true),
                    )
                  ],
                ),
              );
            },
          ),
          onPressedOkButton: () async {
            Navigator.of(context).pop();
            _product.productQuantity = ProductModel.of(context).singleProductQuantity;

            await ProductModel.of(context).updateProduct(
              _product,
              onSuccess: () {
                print("sucesso");

                return;
              },
              onFail: (string) {
                print("Error");
                return;
              },
            );
            updateStocksProductsWithServer(_product);
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
          message(success);
        },
        child: Column(
          children: [
            Container(
              height: 128,
              padding: EdgeInsets.only(top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 85,
                    height: 74,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _product.productImageUrl == null || _product.productImageUrl.isEmpty
                              ? AssetImage("assets/images/ic_camera.png")
                              : NetworkImage(_product.productImageUrl),
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _product.productName,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xFF949191),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.47,
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
                          Column(
                            children: [
                              Text(
                                "R\$ ${_product.productItemPrice}",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                              Text(
                                "R\$ ${_product.productUnitaryPrice}",
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 32),
                              child: Text("${_product.productQuantity}"),
                            ),
                            Row(
                              children: [
                                ScopedModelDescendant<ProductModel>(builder: (context, snapshot, productModel) {
                                  return IconButton(
                                      icon: Icon(Icons.share),
                                      onPressed: () {
                                        productModel.shareLink(_product);
                                      });
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
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
