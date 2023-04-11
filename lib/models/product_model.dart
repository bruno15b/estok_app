import 'package:estok_app/entities/product.dart';
import 'package:estok_app/enums/progress_enum.dart';
import 'package:estok_app/repository/api/product_api.dart';
import 'package:estok_app/repository/api/upload_image_api.dart';
import 'package:estok_app/utils/share_util.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';

class ProductModel extends Model {
  ProductApi _productApi;
  UploadImageApi _uploadImageApi;

  ProductModel.forTestOnly(this._productApi, this._uploadImageApi);

  ProductModel();

  static ProductModel of(BuildContext context) {
    return ScopedModel.of<ProductModel>(context);
  }

  Future<List<Product>> futureProductList = Future.value([]);
  double productsTotalValue = 0;
  double productsTotalQuantity;
  int productUnitQuantity;
  File imageFile;
  ProgressEnum productDownloadProgressChange = ProgressEnum.IDLE;
  ProgressEnum productUploadProgressChange = ProgressEnum.IDLE;

  setState() {
    notifyListeners();
  }

  Future<void> fetchAllProducts(int stockId) async {
    setState();
    futureProductList =
        _productApi != null ? _productApi.getAllProducts(stockId) : ProductApi.instance.getAllProducts(stockId);
    setState();
  }

  Future<void> createNewProduct(Product product, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {
    if (imageFile != null) {
      String urlImage = await sendImageFile(imageFile);
      if (urlImage != null) {
        product.productImageUrl = urlImage;
      } else {
        onFail("Erro ao enviar imagem do produto!");
        return;
      }
    }

    var response = _productApi != null
        ? await _productApi.postNewProduct(product)
        : await ProductApi.instance.postNewProduct(product);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao criar novo Produto!");
    }
    setState();
  }

  Future<void> updateProduct(Product product, {VoidCallback onSuccess, VoidCallback onFail(String message)}) async {

    if (imageFile != null) {
      String urlImage = await sendImageFile(imageFile);
      if (urlImage != null) {
        product.productImageUrl = urlImage;
      } else {
        onFail("Erro ao enviar imagem do produto!");
        return;
      }
      setState();
    }

    var response =
        _productApi != null ? await _productApi.putProduct(product) : await ProductApi.instance.putProduct(product);

    if (response != null) {
      onSuccess();
    } else {
      onFail("Erro ao editar produto!");
    }
    setState();
  }

  deleteProduct(Product product) async {
    var response = _productApi != null
        ? await _productApi.deleteProduct(product)
        : await ProductApi.instance.deleteProduct(product);

    return response;
  }

  Future<String> sendImageFile(File imageFile) async {
    return _uploadImageApi != null
        ? await _uploadImageApi.uploadImage(imageFile)
        : await UploadImageApi.instance.uploadImage(imageFile);
  }

  Future<void> sumProductsTotalValue() async {
    productsTotalValue = 0;

    List<Product> productList = await futureProductList;

    if (productList != null) {
      for (Product product in productList) {
        productsTotalValue += product.productQuantity * product.productItemPrice;
      }
    } else {
      print("Lista de produtos retornou nula.");
    }
    setState();
  }

  Future<double> sumProductsTotalQuantity() async {
    productsTotalQuantity = 0;

    List<Product> productList = await futureProductList;

    for (Product product in productList) {
      productsTotalQuantity += product.productQuantity;
    }
    return productsTotalQuantity;
  }

  updateUnitaryProductQuantity(String action) {
    setState();
    if (action == "add") {
      productUnitQuantity++;
    } else if (action == "remove" && productUnitQuantity > 0) {
      productUnitQuantity--;
    } else {
      return;
    }
    setState();
  }

  Future<void> shareWebsiteLink(Product product) async {
    await ShareUtil.shareLink(product.productUrlSite);
  }
}
