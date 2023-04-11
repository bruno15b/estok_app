import 'dart:async';
import 'package:estok_app/entities/product.dart';
import 'package:estok_app/models/product_model.dart';
import 'package:estok_app/repository/api/product_api.dart';
import 'package:estok_app/repository/api/upload_image_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';

class MockProductApi extends Mock implements ProductApi {}

class MockUploadImageApi extends Mock implements UploadImageApi {}

void main() {
  group("ProductModel", () {
    MockProductApi mockProductApi;
    MockUploadImageApi mockUploadImageApi;
    ProductModel productModel;

    setUp(() {
      mockProductApi = MockProductApi();
      mockUploadImageApi = MockUploadImageApi();
      productModel = ProductModel.forTestOnly(mockProductApi, mockUploadImageApi);
    });

    tearDown(() {
      mockProductApi = null;
      mockUploadImageApi = null;
      productModel = null;
    });

    test("fetchAllProducts deve definir a futureProductList", () async {

      when(mockProductApi.getAllProducts(1)).thenAnswer((_) => Future.value([
        Product(
          id: 1,
          stockId: 1,
          productName: "Product 1",
          productDescription: "Description 1",
          productImageUrl: "",
          productItemPrice: 10.0,
          productUnitaryPrice: 1.0,
          productQuantity: 10,
          productUrlSite: "http://example.com/product1",
        ),
        Product(
          id: 2,
          stockId: 1,
          productName: "Product 2",
          productDescription: "Description 2",
          productImageUrl: '',
          productItemPrice: 20.0,
          productUnitaryPrice: 2.0,
          productQuantity: 20,
          productUrlSite: "http://example.com/product2",
        ),
      ]));

      await productModel.fetchAllProducts(1);

      expect(productModel.futureProductList, completes);
      expect(await productModel.futureProductList, [
        Product(
          id: 1,
          stockId: 1,
          productName: "Product 1",
          productDescription: "Description 1",
          productImageUrl: "",
          productItemPrice: 10.0,
          productUnitaryPrice: 1.0,
          productQuantity: 10,
          productUrlSite: "http://example.com/product1",
        ),
        Product(
          id: 2,
          stockId: 1,
          productName: "Product 2",
          productDescription: "Description 2",
          productImageUrl: '',
          productItemPrice: 20.0,
          productUnitaryPrice: 2.0,
          productQuantity: 20,
          productUrlSite: "http://example.com/product2",
        ),
      ]);
    });

    test("createNewProduct deve chamar postNewProduct", () async {
      final product = Product(
        stockId: 1,
        productName: "Product 1",
        productDescription: "Description 1",
        productImageUrl: "",
        productItemPrice: 10.0,
        productUnitaryPrice: 1.0,
        productQuantity: 10,
        productUrlSite: "http://example.com/product1",
      );

      final onSuccess = () {};
      void Function(String) onFail = (String message) {};

      when(mockUploadImageApi.uploadImage(any)).thenAnswer((_) => Future.value("http://example.com/image.jpg"));
      when(mockProductApi.postNewProduct(product)).thenAnswer((_) => Future.value(200));

      await productModel.createNewProduct(product, onSuccess: onSuccess,onFail: onFail);

      verify(mockProductApi.postNewProduct(product)).called(1);
    });

    test("updateProduct deve atualizar um produto", () async {
      final product = Product(
        stockId: 1,
        productName: "Product 1",
        productDescription: "Description 1",
        productImageUrl: "",
        productItemPrice: 10.0,
        productUnitaryPrice: 1.0,
        productQuantity: 10,
        productUrlSite: "http://example.com/product1",
      );

      void Function() onSuccess = () {};
      void Function(String) onFail = (String message) {};

      when(mockUploadImageApi.uploadImage(any)).thenAnswer((_) => Future.value("http://example.com/image.jpg"));
      when(mockProductApi.putProduct(product)).thenAnswer((_) => Future.value(200));

      await productModel.updateProduct(product, onSuccess: onSuccess, onFail: onFail);

      verify(mockProductApi.putProduct(product)).called(1);
    });

    test("deleteProduct deve excluir um produto", () async {
      final product = Product(
        stockId: 1,
        productName: "Product 1",
        productDescription: "Description 1",
        productImageUrl: "",
        productItemPrice: 10.0,
        productUnitaryPrice: 1.0,
        productQuantity: 10,
        productUrlSite: "http://example.com/product1",
      );

      when(mockProductApi.deleteProduct(product)).thenAnswer((_) => Future.value(200));

      final response = await productModel.deleteProduct(product);

      expect(response, equals(200));
      verify(mockProductApi.deleteProduct(product)).called(1);
    });

    test("sendImageFile deve fazer upload de um arquivo de imagem", () async {
      final imageFile = File("path/to/image.jpg");

      when(mockUploadImageApi.uploadImage(imageFile)).thenAnswer((_) => Future.value("http://example.com/image.jpg"));

      final response = await productModel.sendImageFile(imageFile);

      expect(response, equals("http://example.com/image.jpg"));
      verify(mockUploadImageApi.uploadImage(imageFile)).called(1);
    });

    test("sumProductsTotalValue deve somar o valor total dos produtos", () async {
      final productList = [
        Product(
          id: 1,
          stockId: 1,
          productName: "Product 1",
          productDescription: "Description 1",
          productImageUrl: "",
          productItemPrice: 10.0,
          productUnitaryPrice: 1.0,
          productQuantity: 10,
          productUrlSite: "http://example.com/product1",
        ),
        Product(
          id: 2,
          stockId: 1,
          productName: "Product 2",
          productDescription: "Description 2",
          productImageUrl: '',
          productItemPrice: 20.0,
          productUnitaryPrice: 2.0,
          productQuantity: 20,
          productUrlSite: "http://example.com/product2",
        ),
      ];

      when(mockProductApi.getAllProducts(1)).thenAnswer((_) => Future.value(productList));

      productModel.fetchAllProducts(1);

      await productModel.sumProductsTotalValue();

      expect(productModel.productsTotalValue, 500.0);
    });

    test("sumProductsTotalValue deve lidar com lista de produtos vazia", () async {
      final emptyProductList = <Product>[];

      when(mockProductApi.getAllProducts(1)).thenAnswer((_) => Future.value(emptyProductList));

      productModel.fetchAllProducts(1);

      await productModel.sumProductsTotalValue();

      expect(productModel.productsTotalValue, 0.0);
    });

    test("sumProductsTotalValue deve lidar com uma lista de produtos nula", () async {

      when(mockProductApi.getAllProducts(1)).thenAnswer((_) => Future.value(null));

      productModel.fetchAllProducts(1);

      await productModel.sumProductsTotalValue();

      expect(productModel.productsTotalValue, 0.0);
    });

    test("sumProductsTotalQuantity deve somar quantidade total de produtos", () async {
      final productList = [
        Product(
          id: 1,
          stockId: 1,
          productName: "Product 1",
          productDescription: "Description 1",
          productImageUrl: "",
          productItemPrice: 10.0,
          productUnitaryPrice: 1.0,
          productQuantity: 10,
          productUrlSite: "http://example.com/product1",
        ),
        Product(
          id: 2,
          stockId: 1,
          productName: "Product 2",
          productDescription: "Description 2",
          productImageUrl: '',
          productItemPrice: 20.0,
          productUnitaryPrice: 2.0,
          productQuantity: 20,
          productUrlSite: "http://example.com/product2",
        ),
      ];

      productModel.futureProductList = Future.value(productList);

      double totalQuantity = await productModel.sumProductsTotalQuantity();

      expect(totalQuantity, equals(30));
    });


    test("productUnitQuantity deve atualizar valor de cada produto em si", () {

      productModel.productUnitQuantity = 0;

      productModel.updateUnitaryProductQuantity("add");

      expect(productModel.productUnitQuantity, equals(1));

      productModel.updateUnitaryProductQuantity("remove");

      expect(productModel.productUnitQuantity, equals(0));

      productModel.updateUnitaryProductQuantity("invalid action");

      expect(productModel.productUnitQuantity, equals(0));
    });
  });
}
