import 'dart:convert';

class CategoriaList {
  CategoriaList({
    required this.listado,
  });

  List<Categoria> listado;

  factory CategoriaList.fromJson(String str) => CategoriaList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriaList.fromMap(Map<String, dynamic> json) => CategoriaList(
        listado:
            List<Categoria>.from(json["documents"].map((x) => Categoria.fromMap(x["fields"], x["name"]))),
      );

  Map<String, dynamic> toMap() => {
        "Category": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class Categoria {
  Categoria({
    required this.id,
    required this.categoryName,
  });

  String id;
  String categoryName;

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str), '');

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json, String name) => Categoria(
        id: json["categoryId"]["stringValue"],
        categoryName: json["categoryName"]["stringValue"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "categoryName": categoryName,
      };

  Categoria copy() => Categoria(
      id: id,
      categoryName: categoryName
  );
}
