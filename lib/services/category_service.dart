import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marketplace/models/models.dart';
import 'package:marketplace/services/auth_service.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = 'firestore.googleapis.com';
  final String _baseEndpoint = '/v1/projects/back-cm-um/databases/(default)/documents/';

  List<Categoria> categories = [];
  Categoria? selectedCategory;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadCategories();
  }
  
  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(
      _baseUrl,
      '${_baseEndpoint}categories/',
    );

    String basicAuth = 'Bearer ${TokenStorage.token}';
    final response = await http.get(url, headers: {'Authorization': basicAuth});
    final categoriesMap = CategoriaList.fromMap(json.decode(response.body));
    categories = categoriesMap.listado;
    isLoading = false;
    notifyListeners();
  }
}
