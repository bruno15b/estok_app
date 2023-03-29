import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/models/stock_model.dart';
import 'package:estok_app/ui/validator/add_pages_validators.dart';
import 'package:estok_app/ui/widgets/custom_app_bar.dart';
import 'package:estok_app/ui/widgets/custom_button.dart';
import 'package:estok_app/ui/widgets/custom_text_form_field.dart';
import 'package:estok_app/ui/widgets/message.dart';
import 'package:flutter/material.dart';

class ProductAddPage extends StatefulWidget {
  Product product;
  Stock stock;

  ProductAddPage.newProduct({this.stock});

  ProductAddPage.editProduct({this.product});

  ProductAddPage();

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage>
    with AddPagesValidators {
  var _productNameController = TextEditingController();
  var _productDescriptionController = TextEditingController();
  var _productItemPriceController = TextEditingController();
  var _productUnitaryPriceController = TextEditingController();
  var _productQuantityController = TextEditingController();
  var _productUrlSiteController = TextEditingController();

  final FocusNode _focusProductDescription = FocusNode();
  final FocusNode _focusProductItemPrice = FocusNode();
  final FocusNode _focusProductUnitaryPrice = FocusNode();
  final FocusNode _focusProductQuantity = FocusNode();
  final FocusNode _focusProductUrlSite = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool newProductAdd = true;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      newProductAdd = false;
      _productNameController.text = widget.product.productName;
      _productDescriptionController.text = widget.product.productName;
      _productItemPriceController.text =
          widget.product.productItemPrice.toString();
      _productUnitaryPriceController.text =
          widget.product.productUnitaryPrice.toString();
      _productQuantityController.text =
          widget.product.productQuantity.toString();
      _productUrlSiteController.text = widget.product.productUrlSite;
    } else {
      newProductAdd = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(widget.product?.productName ?? "NOVO PRODUTO"),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 39, left: 24, right: 24, bottom: 72),
          children: [
            SizedBox(
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 200,
                  height: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/ic_camera.png"),
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 11, bottom: 15),
              child: Text(
                "Clique na imagem para tirar foto",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            ),
            Divider(),
            CustomTextFormField(
              controller: _productNameController,
              requestFocus: _focusProductDescription,
              validator: emptyField,
              textAboveFormField: "Nome",
              labelText: "Nome do Produto",
              hintText: "Ex: Heinkiken Original",
              keyboardType: TextInputType.text,
            ),
            CustomTextFormField(
              controller: _productDescriptionController,
              focusNode: _focusProductDescription,
              requestFocus: _focusProductItemPrice,
              validator: emptyField,
              maxLines: 3,
              textAboveFormField: "Descrição",
              labelText: "Descrição do Produto",
              hintText: "Ex: Uma das melhores marcas em uma casa só",
              keyboardType: TextInputType.text,
            ),
            CustomTextFormField(
              controller: _productItemPriceController,
              focusNode: _focusProductItemPrice,
              requestFocus: _focusProductUnitaryPrice,
              validator: currencyValidator,
              textAboveFormField: "Valor item",
              labelText: "Valor total do estoque do produto",
              hintText: "R\$ 45,00",
              keyboardType: TextInputType.number,
            ),
            CustomTextFormField(
              controller: _productUnitaryPriceController,
              focusNode: _focusProductUnitaryPrice,
              requestFocus: _focusProductQuantity,
              validator: currencyValidator,
              textAboveFormField: "Valor unitário",
              labelText: "Valor unitário do produto",
              hintText: "R\$ 45,00",
              keyboardType: TextInputType.number,
            ),
            CustomTextFormField(
              controller: _productQuantityController,
              focusNode: _focusProductQuantity,
              requestFocus: _focusProductUrlSite,
              validator: onlyNumbers,
              textAboveFormField: "Quantidade",
              labelText: "Informe a quantidade do produto",
              hintText: "Ex: 10",
              keyboardType: TextInputType.number,
            ),
            CustomTextFormField(
              controller: _productUrlSiteController,
              focusNode: _focusProductUrlSite,
              validator: emptyField,
              textAboveFormField: "Site",
              labelText: "Informe a url",
              hintText: "ex: www.google.com.br",
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                textButton: "CADASTRAR", onPressed: () => productOnPressed()),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  productOnPressed() async {
    FocusScope.of(context).unfocus();
    if (this._formKey.currentState.validate()) {
      Product product = Product(
        productName: _productNameController.text,
        productDescription: _productDescriptionController.text,
        productItemPrice: double.parse(_productItemPriceController.text),
        productUnitaryPrice: double.parse(_productUnitaryPriceController.text),
        productQuantity: int.parse(_productQuantityController.text),
        productUrlSite: _productUrlSiteController.text,
        productImageUrl: "",
      );

      if (newProductAdd) {
        product.stockId = widget.stock.id;
        await ProductModel.of(context).createNewProduct(product, onSuccess: () {
          Message.onSuccess(
              scaffoldKey: _scaffoldKey,
              message: "Produto adicionado com sucesso",
              seconds: 5,
              onPop: (value) async {
                try {
                  await Future.delayed(Duration(milliseconds: 500));
                  await ProductModel.of(context).fetchProducts(product.stockId);
                  await Future.delayed(Duration(milliseconds: 500));
                  await ProductModel.of(context).sumProductsValue();
                  await ProductModel.of(context)
                      .sumStockQuantity(product.stockId);
                  await Future.delayed(Duration(milliseconds: 500));
                  await StockModel.of(context).fetchStocks();

                } catch (e) {
                  print(e);
                } finally {
                  Navigator.of(context).pop();
                }
              });
          return;
        }, onFail: (string) {
          Message.onFail(
            scaffoldKey: _scaffoldKey,
            message: "Erro ao adicionar Produto!",
            seconds: 3,
          );
          return;
        });
      } else {
        product.id = widget.product.id;
        product.stockId = widget.product.stockId;
        await ProductModel.of(context).updateProduct(product, onSuccess: () {
          Message.onSuccess(
              scaffoldKey: _scaffoldKey,
              message: "Produto editado com sucesso",
              seconds: 5,
              onPop: (value) async {
                try {
                  await Future.delayed(Duration(milliseconds: 500));
                  await ProductModel.of(context).fetchProducts(product.stockId);
                  await Future.delayed(Duration(milliseconds: 500));
                  await ProductModel.of(context).sumProductsValue();
                  await ProductModel.of(context)
                      .sumStockQuantity(product.stockId);
                  await Future.delayed(Duration(milliseconds: 500));
                  await StockModel.of(context).fetchStocks();

                } catch (e) {
                  print(e);
                } finally {
                  Navigator.of(context).pop();
                }
              });
          return;
        }, onFail: (string) {
          Message.onFail(
            scaffoldKey: _scaffoldKey,
            message: "Erro ao editar Produto!",
            seconds: 3,
          );
          return;
        });
      }
    }
  }
}
