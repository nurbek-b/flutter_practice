import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String mainUrl = "http://agrimatico-backend.ml/";

class Categories with ChangeNotifier{
  final int id;
  final int parent;
  final String titleKy;
  final String titleRu;
  final String growingTechniqueKy;
  final String growingTechniqueRu;
  final String icon;
  final List<Categories> children;

  Categories({this.id, this.parent, this.titleKy,
    this.titleRu, this.growingTechniqueKy, this.icon,
    this.growingTechniqueRu, this.children});

  factory Categories.fromJson(dynamic json) {
      return Categories(
          id: json['id'],
          titleKy: json['title_ky'],
          titleRu: json['title_ru'],
          growingTechniqueKy: json['growing_technique_ky'],
          growingTechniqueRu: json['growing_technique_ru'],
          icon: json['icon'],
          parent: json['parent'] == null ? null : json['parent']
      );
  }

    List<Categories> _categories = [];

  Future<void> fetchAndSetCategories()async{
    final categoriesUrl = "${mainUrl}api/v1/categories/";
    try {
      final response = await http.get(categoriesUrl);
      final categoriesData = json.decode(utf8.decode(response.bodyBytes));
      final List<Categories> loadedCat = [];
      categoriesData?.forEach((cat){
        if (cat.containsKey("children")) {
          loadedCat.add(Categories(
              id: cat["id"],
              titleKy: cat['title_ky'],
              titleRu: cat['title_ru'],
              growingTechniqueKy: cat['growing_technique_ky'],
              growingTechniqueRu: cat['growing_technique_ru'],
              icon: cat['icon'],
              children: []));
              cat['children']?.forEach((subCat){
                if (subCat == null){
                } else {loadedCat.last.children.add(Categories(
                    id: subCat['id'],
                    titleKy: subCat['title_ky'],
                    titleRu: subCat['title_ru'],
                    growingTechniqueKy: subCat['growing_technique_ky'],
                    growingTechniqueRu: subCat['growing_technique_ru'],
                    icon: subCat['icon']
                ),
                );
              }
            });
          };
        });
      _categories = loadedCat;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Categories> get categories{
    return [..._categories];
  }
}

