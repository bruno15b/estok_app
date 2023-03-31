import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/validator/add_pages_validators.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:scoped_model/scoped_model.dart';

class StockAddPage extends StatefulWidget {
  Stock stock;

  StockAddPage({this.stock});

  @override
  _StockAddPageState createState() => _StockAddPageState();
}

class _StockAddPageState extends State<StockAddPage> with AddPagesValidators {
  String _selectedOption;

  final FocusNode _focusEnterDate = FocusNode();
  final FocusNode _focusValidityDate = FocusNode();

  var _stockDescriptionController = TextEditingController();
  var _stockEnterDateController = TextEditingController();
  var _stockValidityDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool newStockAdd = true;


  @override
  void initState() {
    super.initState();

    if (widget.stock != null) {
      newStockAdd = false;
      _stockDescriptionController.text = widget.stock.stockDescription;
      _stockEnterDateController.text =
          StockModel.of(context).formatDateToString(widget.stock.enterDate);
      _stockValidityDateController.text =
          StockModel.of(context).formatDateToString(widget.stock.validityDate);
      StockModel.of(context).onChangeTypeOfStock(widget.stock.typeOfStock);
    } else {
      StockModel.of(context).onChangeTypeOfStock("CAIXA");
      newStockAdd = true;
    }
  }

  _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _selectedOption = "CAIXA";
                    StockModel.of(context).onChangeTypeOfStock(_selectedOption);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "CAIXA",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    _selectedOption = "GRADE";
                    StockModel.of(context).onChangeTypeOfStock(_selectedOption);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "GRADE",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    _selectedOption = "PACOTE";
                    StockModel.of(context).onChangeTypeOfStock(_selectedOption);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "PACOTE",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(titleText:widget.stock?.stockDescription ?? "NOVO ESTOQUE"),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 31, left: 24, right: 24),
          children: [
            CustomTextFormField(
              validator: emptyField,
              requestFocus: _focusEnterDate,
              textAboveFormField: "Descrição",
              labelText: "Descrição do estoque",
              hintText: "Ex: Engradados Cerveja",
              keyboardType: TextInputType.text,
              controller: _stockDescriptionController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: CustomTextFormField(
                    dateFormatter: true,
                    keyboardType: TextInputType.datetime,
                    textAboveFormField: "Data de entrada",
                    labelText: "Entrada",
                    hintText: "12/12/2012",
                    controller: _stockEnterDateController,
                    focusNode: _focusEnterDate,
                    requestFocus: _focusValidityDate,
                    validator: validateDate,
                    maxLength: 10,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: CustomTextFormField(
                    dateFormatter: true,
                    keyboardType: TextInputType.datetime,
                    textAboveFormField: "Data de validade",
                    labelText: "Saída",
                    hintText: "12/12/2012",
                    controller: _stockValidityDateController,
                    focusNode: _focusValidityDate,
                    validator: validateDate,
                    maxLength: 10,
                  ),
                ),
              ],
            ),
            ScopedModelDescendant<StockModel>(
                builder: (context, snapshot, stockModel) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 19),
                    child: Text("Tipo",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16)),
                  ),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      _showOptionsDialog();
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 11, 0, 11),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Theme.of(context).accentColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          Text(
                            stockModel.typeOfStock,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(
              height: 57,
            ),
            CustomButton(
              textButton: newStockAdd ? "CADASTRAR" : "EDITAR",
              onPressed: () => stockOnPressed(),
            ),
          ],
        ),
      ),
    );
  }

  void stockOnPressed() async {
    FocusScope.of(context).unfocus();
    if (this._formKey.currentState.validate()) {

      DateTime _enterDate = StockModel.of(context)
          .formatStringToDate(_stockEnterDateController.text);
      DateTime _validityDate = StockModel.of(context)
          .formatStringToDate(_stockValidityDateController.text);
      String typeOfStock = StockModel.of(context).typeOfStock;

      Stock stock = Stock(
        stockDescription: _stockDescriptionController.text,
        typeOfStock: typeOfStock,
        enterDate: _enterDate,
        validityDate: _validityDate,
      );

      if (newStockAdd) {
       await StockModel.of(context).createNewStock(stock, onSuccess: () {
          Message.onSuccess(
              scaffoldKey: _scaffoldKey,
              message: "Estoque adicionado com sucesso",
              seconds: 3,
              onPop: (value) {
                Navigator.of(context).pop();
              });
          return;
        }, onFail: (string) {
          Message.onFail(
            scaffoldKey: _scaffoldKey,
            message: "Erro ao adicionar estoque.!",
            seconds: 3,
          );
          return;
        });
      } else {
        stock.id = widget.stock.id;
        stock.stockTotalProductQuantity = widget.stock.stockTotalProductQuantity;
        StockModel.of(context).updateStock(
          stock,
          onSuccess: () {
            Message.onSuccess(
                scaffoldKey: _scaffoldKey,
                message: "Estoque editado com sucesso",
                seconds: 3,
                onPop: (value) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
            return;
          },
          onFail: (string) {
            Message.onFail(
              scaffoldKey: _scaffoldKey,
              message: "Erro ao editar estoque.!",
              seconds: 3,
            );
            return;
          },
        );
      }

      return;
    }
  }
}