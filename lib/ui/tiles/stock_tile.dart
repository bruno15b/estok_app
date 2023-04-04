import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/enums/stock_status.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
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
      child: InkWell(
            onTap: (){

              ProductModel.of(context).fetchAllProducts(_stock.id);
              ProductModel.of(context).sumStockTotalPrice();
              StockModel.of(context).saveOpenStock(_stock);
              StockModel.of(context).colorStockStatusReplacer = null;
              StockModel.of(context).textStockStatusReplacer = null;

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
                borderRadius: BorderRadius.circular(18),
              ),
              height: 87,
              margin: EdgeInsets.only(top: 7.5, left: 10, right: 10,bottom:7.5),
              padding: EdgeInsets.only(top: 15, left: 22, right: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this._stock.stockDescription.toUpperCase(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(children: [
                        Text(
                          "TOTAL: ${this._stock.stockTotalProductQuantity.round().toString()}",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.circle,
                            size: 14,
                            color: colorStockStatus,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                          width: 80,
                          child: Text(
                            this._stock.stockStatus,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 11.5,
                              color: colorStockStatus,
                            ),
                          ),
                        ),
                      ),],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
