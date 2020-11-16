import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/categories.dart';

String mainUrl = "http://agrimatico-backend.ml/";

class DiseaseOrPestItem with ChangeNotifier {
  final String id;
  final String titleKy;
  final String titleRu;
  final Categories category;
  final String descriptionKy;
  final String descriptionRu;
  final String type;
  final List choice;
  bool addedToCart;


  DiseaseOrPestItem({
    this.id,
    this.titleKy,
    this.titleRu,
    this.category,
    this.descriptionKy,
    this.descriptionRu,
    this.type,
    this.choice,
    this.addedToCart = false,
  });

}


class Diseases with ChangeNotifier {
  List<DiseaseOrPestItem> _items = [];
  List<DiseaseOrPestItem> _itemsFiltered = [];
  // var _showFavoritesOnly = false;

  List<DiseaseOrPestItem> get items {
    return [..._items].toList();
  }

  List<DiseaseOrPestItem> get itemsFiltered {
    return [..._itemsFiltered].toList();
  }

  Future<void> fetchAndSetDiseasesPests() async {
    final url = '${mainUrl}api/v1/diseases-pests/';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(utf8.decode(response.bodyBytes));
      final List<DiseaseOrPestItem> loadedDiseasesOrPests = [];
      extractedData?.forEach((item) {
        loadedDiseasesOrPests.add(DiseaseOrPestItem(
            id: item["id"].toString(),
            titleKy: item['title_ky'],
            titleRu: item['title_ru'],
            category: item['category'] == null ? null : Categories.fromJson(item["category"]),
            descriptionKy: item['description_ky'],
            descriptionRu: item['description_ru'],
            type: item['type'],
            choice: item['choice'],
        ),
        );
      });
      _items = loadedDiseasesOrPests;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }


  DiseaseOrPestItem findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  List<DiseaseOrPestItem> findByDiseasesPestsType(String type, Categories category) {
    List<DiseaseOrPestItem> filteredItems = _items.where((item) => item.type.toString() == type).toList();
    return filteredItems.where((element) => element.category?.titleRu == category.titleRu).toList();
  }
}
