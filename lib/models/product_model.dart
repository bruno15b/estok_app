import 'package:estok_app/entities/product.dart';
import 'package:estok_app/models/user_model.dart';
import 'package:estok_app/repository/api/product_api.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  Future<List<Product>> futureProductList;

  static ProductModel of(BuildContext context) {
    return ScopedModel.of<ProductModel>(context);
  }

  setState() {
    notifyListeners();
  }

  Future<void> fetchProducts(BuildContext context,int productId) async {

    this.futureProductList = Future.delayed(Duration(seconds: Duration.millisecondsPerDay));

    setState();

    final userToken = await UserRepository.instance.getUserToken();
    final renewedToken = UserModel.of(context).renewToken;
    this.futureProductList = ProductApi.instance.getAllProducts(productId, userToken, renewedToken);

    setState();
  }

}
