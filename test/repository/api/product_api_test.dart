import 'package:estok_app/entities/product.dart';
import 'package:estok_app/entities/user.dart';
import 'package:estok_app/repository/api/product_api.dart';
import 'package:estok_app/repository/local/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('ProductApi', () {

    MockUserRepository userRepository;
    MockClient client;
    ProductApi productApi;

    setUp(() {
      client = MockClient();
      userRepository = MockUserRepository();
      productApi = ProductApi.forTestOnly(client, userRepository);
    });


    tearDown(() {
      client = null;
      userRepository = null;
      productApi = null;
    });

    test("getAllProducts deve retorna uma lista de produtos em caso de sucesso", () async {

      final user = User(
        id: 1,
        name: "Bruno Borges Machado",
        email: "brunoborges@gmail.com",
        password: "123456789",
        telephone: "555-5555",
        token: "12345678901011",
      );

      final response = http.Response('''
    {
      "status": 200,
      "message": "",
      "data": [
        {
          "id": 1,
          "estoque_id": 1,
          "nome": "Product 1",
          "descricao": "Description 1",
          "imagem": "",
          "valor_item": 10.0,
          "valor_unitario": 1.0,
          "quantidade": 10,
          "site": "http://example.com/product1"
        },
        {
          "id": 2,
          "estoque_id": 1,
          "nome": "Product 2",
          "descricao": "Description 2",
          "imagem": "",
          "valor_item": 20.0,
          "valor_unitario": 2.0,
          "quantidade": 20,
          "site": "http://example.com/product2"
        }
      ]
    }
''', 200);

      when(userRepository.getUser()).thenAnswer((_) => Future.value(user));

      when(client.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) => Future.value(response));

      final products = await productApi.getAllProducts(1);

      verify(userRepository.getUser()).called(1);

      verify(client.get(any, headers: anyNamed("headers"))).called(1);

      expect(products, [
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

    test("getAllProducts deve retorna null em caso de falha", () async {
      final user = User(token: "token");
      final response = http.Response('{"status": 500, "message": "Internal Server Error"}', 500);

      when(userRepository.getUser()).thenAnswer((_) => Future.value(user));

      when(client.get(any, headers: anyNamed("headers"))).thenAnswer((_) => Future.value(response));

      final products = await productApi.getAllProducts(1);

      expect(products, isNull);
    });

    test("postNewProduct deve retornar 200 em caso de sucesso", () async {
      final user = User(
        id: 1,
        name: "Bruno Borges Machado",
        email: "brunoborges@gmail.com",
        password: "123456789",
        telephone: "555-5555",
        token: "12345678901011",
      );

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

      final response = http.Response(
        '{"status": 200, "message": "Cadastrado com sucesso!!"}',
        200,
      );

      when(userRepository.getUser()).thenAnswer((_) => Future.value(user));
      when(client.post(
        any,
        headers: anyNamed("headers"),
        body: anyNamed("body"),
      )).thenAnswer((_) => Future.value(response));

      final result = await productApi.postNewProduct(product);

      verify(userRepository.getUser()).called(1);
      verify(
        client.post(
          any,
          headers: anyNamed("headers"),
          body: anyNamed("body"),
        ),
      ).called(1);

      expect(result, 200);
    });

    test("postNewProduct deve retornar null em caso de falha", () async {
      final user = User(token: "token");
      final product = Product(stockId: 1);
      final response = http.Response(
        '{"status": 500, "message": "Internal Server Error"}',
        500,
      );

      when(userRepository.getUser()).thenAnswer((_) => Future.value(user));
      when(client.post(
        any,
        headers: anyNamed("headers"),
        body: anyNamed("body"),
      )).thenAnswer((_) => Future.value(response));

      final result = await productApi.postNewProduct(product);

      expect(result, isNull);
    });

    test("putProduct deve retornar 200 em caso de sucesso", () async {
      final user = User(
        id: 1,
        name: "Bruno Borges Machado",
        email: "brunoborges@gmail.com",
        password: "123456789",
        telephone: "555-5555",
        token: "12345678901011",
      );

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

      final response = http.Response(
        '{"status": 200, "message": "Atualizado com sucesso!!"}',
        200,
      );

      when(userRepository.getUser()).thenAnswer((_) => Future.value(user));
      when(client.put(
        any,
        headers: anyNamed("headers"),
        body: anyNamed("body"),
      )).thenAnswer((_) => Future.value(response));

      final result = await productApi.putProduct(product);

      verify(userRepository.getUser()).called(1);
      verify(
        client.put(
          any,
          headers: anyNamed("headers"),
          body: anyNamed("body"),
        ),
      ).called(1);

      expect(result, 200);
    });

    test("putProduct deve retornar null em caso de falha", () async {
      final user = User(token: "token");
      final product = Product(stockId: 1);
      final response = http.Response(
        '{"status": 500, "message": "Internal Server Error"}',
        500,
      );

      when(userRepository.getUser()).thenAnswer((_) => Future.value(user));
      when(client.put(
        any,
        headers: anyNamed("headers"),
        body: anyNamed("body"),
      )).thenAnswer((_) => Future.value(response));

      final result = await productApi.putProduct(product);

      expect(result, isNull);
    });


  });
}
