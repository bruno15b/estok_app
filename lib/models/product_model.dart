import 'package:estok_app/entities/product.dart';
import 'package:estok_app/repository/api/product_api.dart';
import 'package:estok_app/repository/api/upload_image_api.dart';
import 'package:estok_app/util/share_util.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';

class ProductModel extends Model {
  Future<List<Product>> futureProductList = Future.value([]);
  double totalValueOfStock = 0;
  double totalProductQuantityInStockReplacer;
  int unitaryProductQuantity;
  File imageFile;

  static ProductModel of(BuildContext context) {
    return ScopedModel.of<ProductModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetchAllProducts(int stockId) async {
    setState();
    futureProductList = ProductApi.instance.getAllProducts(stockId);
    setState();
  }

  Future<void> createNewProduct(Product product,
      {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    print(imageFile);

    if (imageFile != null) {
      String urlImage = await sendImageFile(imageFile);
      if (urlImage != null) {
        product.productImageUrl = urlImage;
      } else {
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
    print(imageFile);

    if (imageFile != null) {
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
    return response;
  }

  Future<String> sendImageFile(File imageFile) async {
    return await UploadImageApi.instance.uploadImage(imageFile);
  }

  Future<void> sumStockTotalPrice() async {
    totalValueOfStock = 0;

    List<Product> productList = await futureProductList;

    if (productList != null) {
      for (Product product in productList) {
        totalValueOfStock += product.productQuantity * product.productItemPrice;
      }
    } else {
      print("Lista de produtos retornou nula.");
    }
    setState();
  }

  Future<double> sumStockTotalProductQuantity() async {
    totalProductQuantityInStockReplacer = 0;

    List<Product> productList = await futureProductList;

    for (Product product in productList) {
      totalProductQuantityInStockReplacer += product.productQuantity;
    }
    return totalProductQuantityInStockReplacer;
  }


  updateUnitaryProductQuantity(String action) {
    setState();
    if (action == "add") {
      unitaryProductQuantity++;
    } else if(action == "remove") {
      unitaryProductQuantity--;
    }else{
      return;
    }
    setState();
  }

  Future<void> shareLink(Product product) async {
    await ShareUtil.shareLink(product.productUrlSite);
  }

}
