import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/enums/stock_status.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/ui/pages/stock_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class StockTile extends StatelessWidget {
  final Stock _stock;

  StockTile(this._stock);

  @override
  Widget build(BuildContext context) {

    Color colorStockStatus;

    if (_stock.stockStatus == StockStatus.EM_ESTOQUE.stringValue) {
      colorStockStatus = StockStatus.EM_ESTOQUE.colorValue;
    } else if (_stock.stockStatus == StockStatus.EM_FALTA.stringValue) {
      colorStockStatus = StockStatus.EM_FALTA.colorValue;
    } else if(_stock.stockStatus == StockStatus.EM_AVISO.stringValue) {
      colorStockStatus =  StockStatus.EM_AVISO.colorValue;
    }

    return Card(
      elevation: 0,
      child: ScopedModelDescendant<ProductModel>(
        builder: (context, snapshot,productModel) {
          return InkWell(
            onTap: (){
              productModel.colorStockStatus = null;
              productModel.textStockStatus = null;
              productModel.totalProductQuantityInStock = null;

              ProductModel.of(context).fetchAllProducts(_stock.id).then((_) {
                return ProductModel.of(context).sumStockQuantity(_stock.id);
              });

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return StockShowPage(this._stock, colorStockStatus);
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE7EFF2),
                borderRadius: BorderRadius.circular(15),
              ),
              height: 81,
              margin: EdgeInsets.only(top: 15, left: 10, right: 10),
              padding: EdgeInsets.only(top: 12, left: 22, right: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this._stock.stockDescription,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(children: [
                        Text(
                          "TOTAL: ${this._stock.stockTotalProductQuantity.toString()}",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 42,
                        ),
                        Text(
                          "TIPO: ${this._stock.typeOfStock.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.circle,
                            size: 11,
                            color: colorStockStatus,
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.17,
                        child: Text(
                          this._stock.stockStatus,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            color: colorStockStatus,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
