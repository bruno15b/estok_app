import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/stock.dart';
import 'package:estok_app/repository/api/product_api.dart';
import 'package:estok_app/repository/api/stock_api.dart';
import 'package:estok_app/repository/local/stock_repository.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  Future<List<Product>> futureProductList = Future.value([]);
  double totalValue = 0;
  double totalProductQuantityInStock;
  Color colorStatus;
  String stockStatus;

  static ProductModel of(BuildContext context) {
    return ScopedModel.of<ProductModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetchProducts(int stockId) async {
    setState();

    final userToken = await UserRepository.instance.getUserToken();
    futureProductList = ProductApi.instance.getAllProducts(userToken, stockId);

     await sumProductsValue();

    setState();
  }

  Future<void>  createNewProduct(Product product,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();

    var response = await ProductApi.instance.postNewProduct(userToken, product);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao criar novo Produto!");
    }
  }

  Future<void> updateProduct(Product product,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    final userToken = await UserRepository.instance.getUserToken();
    var response = await ProductApi.instance.putProduct(userToken, product);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao editar produto!");
    }
  }

   deleteProduct(Product product) async {
    final userToken = await UserRepository.instance.getUserToken();
    var response = await ProductApi.instance.deleteProduct(userToken, product);
    if(response == true){
      await fetchProducts(product.stockId);
      await sumStockQuantity(product.stockId);
    }else{
      await fetchProducts(product.stockId);
    }
    return response;
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
    final userToken = await UserRepository.instance.getUserToken();

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


    await StockApi.instance.putStock(userToken, selectedStock);
  }

  stockUpdateInfo(double stockTotalQuantity) {

    print(stockTotalQuantity);
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


}
