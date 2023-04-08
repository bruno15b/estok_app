import 'package:estok_app/entities/product.dart';
import 'package:estok_app/models/history_model.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/ui/pages/product_add_page.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:estok_app/utils/server_sync_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  final void Function(bool, Product) deleteProductResponseFn;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ProductTile(this._product, this.deleteProductResponseFn, this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ProductModel
            .of(context)
            .productUnitQuantity = null;
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
            _product.productQuantity = ProductModel
                .of(context)
                .productUnitQuantity;

            await ProductModel.of(context).updateProduct(
              _product,
              onSuccess: () {
                Message.onSuccess(
                    scaffoldKey: scaffoldKey,
                    message: "Quantidade atualizada com sucesso!",
                    onPop: (_) {
                      ServerSyncUtil.updateStocksProductsWithServer(context,_product);
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
          final bool deleteResponse = await ProductModel.of(context).deleteProduct(_product);
          deleteProductResponseFn(deleteResponse, _product);
        },
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.only(top: 14),
              margin: EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
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
                              child: Container(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      _product.productName,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline1
                                            .color,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      _product.productDescription,
                                      maxLines: 3,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        color: Theme
                                            .of(context)
                                            .textTheme
                                            .headline4
                                            .color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: MediaQuery
                                    .of(context)
                                    .orientation == Orientation.landscape
                                    ? EdgeInsets.only(right: 70)
                                    : EdgeInsets.only(right: 0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 70,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "R\$ ${_product.productItemPrice}",
                                          style: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 60,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "R\$ ${_product.productUnitaryPrice}",
                                          style: TextStyle(fontSize: 12, color: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText1
                                              .color),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 28,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 35, top: 5),
                              child: Text(
                                "${_product.productQuantity}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1
                                      .color,
                                ),
                              ),
                            ),
                            Padding(
                              padding: MediaQuery
                                  .of(context)
                                  .orientation == Orientation.landscape
                                  ? EdgeInsets.only(right: 70)
                                  : EdgeInsets.only(right: 15),
                              child: Row(
                                children: [
                                  IconButton(
                                      constraints: BoxConstraints(maxHeight: 36),
                                      icon: Icon(
                                        Icons.share,
                                        size: 22,
                                      ),
                                      onPressed: () {
                                        ProductModel.of(context).shareWebsiteLink(_product);
                                      }),
                                  SizedBox(width: 5,),
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