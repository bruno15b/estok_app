import 'package:estok_app/entities/product.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/ui/pages/product_add_page.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  final void Function(bool) message;

  ProductTile(this._product, this.message);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) async {
        final bool success =
            await ProductModel.of(context).deleteProduct(_product);
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
                        image:_product.productImageUrl == null || _product.productImageUrl.isEmpty ? AssetImage("assets/images/ic_camera.png") : NetworkImage(_product.productImageUrl), fit: BoxFit.fitHeight),
                  ),
                ),
                Column(children: [
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
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 13),
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
                            IconButton(
                                icon: Icon(Icons.share), onPressed: () {}),
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
                ])
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
