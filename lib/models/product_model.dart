import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/repository/api/product_api.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:estok_app/repository/api/upload_image_api.dart';
import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';

class ProductModel extends Model {
  Future<List<Product>> futureProductList = Future.value([]);
  double totalValue = 0;
  double totalProductQuantityInStock;
  Color colorStatus;
  String stockStatus;
  bool isLoading = false;

  File imageFile;


  static ProductModel of(BuildContext context) {
    return ScopedModel.of<ProductModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetchProducts(int stockId) async {

    setState();

    futureProductList = ProductApi.instance.getAllProducts(stockId);

     await sumProductsValue();
    setState();
  }

  Future<void>  createNewProduct(Product product,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {

    print(imageFile);

    if(imageFile!= null){
      String urlImage = await sendImageFile(imageFile);
      if(urlImage != null){
        product.productImageUrl = urlImage;
      }else{
        onFail("Erro ao enviar imagem do produto!");
        return;
      }

    }

    var response = await ProductApi.instance.postNewProduct(product);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao criar novo Produto!");
    }
  }

  Future<void> updateProduct(Product product,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {

    if(imageFile!= null) {
      String urlImage = await sendImageFile(imageFile);
      if (urlImage != null) {
        product.productImageUrl = urlImage;
      } else {
        onFail("Erro ao enviar imagem do produto!");
        return;
      }
    }

    var response = await ProductApi.instance.putProduct(product);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao editar produto!");
    }
  }

   deleteProduct(Product product) async {
    var response = await ProductApi.instance.deleteProduct(product);
    if(response == true){
      await fetchProducts(product.stockId);
      await sumStockQuantity(product.stockId);
    }else{
      await fetchProducts(product.stockId);
    }
    return response;
  }

  Future<String> sendImageFile(File imageFile) async{
    return await UploadImageApi.instance.uploadImage(imageFile);
  }

  sumProductsValue() async {

    totalValue = 0;

    List<Product> productList = await futureProductList;

    if (productList != null) {
      for (Product product in productList) {
        totalValue += product.productQuantity * product.productItemPrice;
      }
    } else {
      print("Lista de produtos retornou nula.");
    }
    setState();
  }

  Future<void> sumStockQuantity(int stockId) async {

    List<Product> productList = await futureProductList;

    totalProductQuantityInStock = 0;

    for (Product product in productList) {
      totalProductQuantityInStock += product.productQuantity;
    }

    stockUpdateInfo(totalProductQuantityInStock);

    List<Stock> stockList = await StockRepository.instance.getStockList();

    Stock selectedStock;

    for (int i = 0; i < stockList.length; i++) {
      if (stockList[i].id == stockId) {
        selectedStock = stockList[i];
        break;
      }
    }

    selectedStock.stockTotalProductQuantity = totalProductQuantityInStock;


    await StockApi.instance.putStock(selectedStock);
  }

  stockUpdateInfo(double stockTotalQuantity) {

    if (stockTotalQuantity > 5 ) {
      stockStatus = "EM ESTOQUE";
      colorStatus = Color(0xFF3AA637);
    } else if (stockTotalQuantity == 0) {
      stockStatus = "EM FALTA";
      colorStatus = Color(0xFFA63737);
    } else {
      stockStatus = "EM AVISO";
      colorStatus = Color(0XFFDCC707);
    }

    setState();
  }


  void setLoading(bool value) {
    isLoading = value;
    setState();
  }




}
