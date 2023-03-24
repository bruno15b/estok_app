import 'package:estok_app/entities/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product _product;

  ProductTile(this._product);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 111,
          padding: EdgeInsets.only(top: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 74,
                width: 85,
                color: Colors.blueGrey[100],
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
                              fontWeight: FontWeight.w700,fontSize: 13),
                        ),
                        Text( "R\$ ${_product.productUnitaryPrice}",style: TextStyle(
  fontSize: 11),)
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
                          IconButton(icon: Icon(Icons.share), onPressed: () {}),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {})
                        ],
                      )
                    ],
                  ),
                )
              ])
            ],
          ),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFFBEBBBB),
        )
      ],
    );
  }
}
