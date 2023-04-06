import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/enums/stock_status_enum.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/pages/stock_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:estok_app/enums/extensions/stock_status_enum_extension.dart';

class StockTile extends StatelessWidget {
  final Stock _stock;

  StockTile(this._stock);

  @override
  Widget build(BuildContext context) {

    Color colorStockStatus;

    if (_stock.stockStatus == StockStatusEnum.EM_ESTOQUE.stringValue) {
      colorStockStatus = StockStatusEnum.EM_ESTOQUE.colorValue;
    } else if (_stock.stockStatus == StockStatusEnum.EM_FALTA.stringValue) {
      colorStockStatus = StockStatusEnum.EM_FALTA.colorValue;
    } else if(_stock.stockStatus == StockStatusEnum.EM_AVISO.stringValue) {
      colorStockStatus =  StockStatusEnum.EM_AVISO.colorValue;
    }

    return Card(
      elevation: 0,
      child: InkWell(
            onTap: (){

              ProductModel.of(context).fetchAllProducts(_stock.id);
              ProductModel.of(context).sumProductsTotalValue();
              StockModel.of(context).setSelectedStock(_stock);
              StockModel.of(context).selectedStockStatusColor = null;
              StockModel.of(context).selectedStockStatusText = null;

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
              height: 90,
              margin: EdgeInsets.only(top: 0,bottom:16),
              padding: EdgeInsets.only(top: 15, left: 22, right: 12, bottom: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this._stock.stockDescription.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Text(
                          "TOTAL: ${this._stock.stockTotalProductQuantity.round().toString()}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF495057),
                          ),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Text(
                          "TIPO: ${this._stock.typeOfStock.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF495057),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Column(
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
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
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
                      ),],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
