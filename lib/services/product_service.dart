import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/models/models.dart';
import 'package:marketplace/services/auth_service.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'firestore.googleapis.com';
  final String _baseEndpoint = '/v1/projects/back-cm-um/databases/(default)/documents/';

  List<Product> products = [];
  Product? selectedProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProductService() {
    loadProducts();
  }
  
  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(
      _baseUrl,
      '${_baseEndpoint}products/',
    );

    String basicAuth = 'Bearer ${TokenStorage.token}';
    final response = await http.get(url, headers: {'Authorization': basicAuth});
    final productsMap = ProductList.fromMap(json.decode(response.body));
    products = productsMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(Product product) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productId == 0) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
     final url = Uri.https(
      _baseUrl,
      '${_baseEndpoint}products/${product.id}',
    );

    String basicAuth = 'Bearer ${TokenStorage.token}';

    var productData = {
      "fields": {
        "productId": {"integerValue": product.productId.toString()},
        "productName": {"stringValue": product.productName},
        "productPrice": {"integerValue": product.productPrice.toString()},
        "productImage": {"stringValue": product.productImage},
        "productState": {"stringValue": product.productState},
        "categoryId": {"stringValue": product.categoryId},
      }
    };

    // final response =
    await http.patch(url, body: json.encode(productData), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final index = products
        .indexWhere((element) => element.productId == product.productId);
    products[index] = product;

    return '';
  }

  Future createProduct(Product product) async {
    final url = Uri.https(
      _baseUrl,
      '${_baseEndpoint}products/',
    );

    String basicAuth = 'Bearer ${TokenStorage.token}';

    var productData = {
      "fields": {
        "productId": {"integerValue": Random().nextInt(1000)},
        "productName": {"stringValue": product.productName},
        "productPrice": {"integerValue": product.productPrice.toString()},
        "productImage": {"stringValue": product.productImage},
        "productState": {"stringValue": product.productState},
        "categoryId": {"stringValue": product.categoryId},
      }
    };

    // final response = 
    await http.post(url, body: json.encode(productData), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });

    products.add(product);
    return '';
  }

  Future deleteProduct(Product product, BuildContext context) async {
    final url = Uri.https(
      _baseUrl,
      '${_baseEndpoint}products/${product.id}',
    );

    String basicAuth = 'Bearer ${TokenStorage.token}';
    // final response = 
    await http.delete(url, headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });


    products.clear();
    loadProducts();
    Navigator.of(context).pushNamed('list');
    return '';
  }
}
