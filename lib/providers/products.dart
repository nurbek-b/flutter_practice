import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/categories.dart';
import 'package:shop_app/providers/product.dart';

String mainUrl = "http://agrimatico-backend.ml/";


class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> _itemsFiltered = [];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    return [..._items].toList();
  }

  List<Product> get itemsFiltered {
    return [..._itemsFiltered].toList();
  }

  Future<void> fetchAndSetProducts() async {
    final url = '${mainUrl}api/v1/products/';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(utf8.decode(response.bodyBytes));
      final List<Product> loadedProducts = [];
      extractedData?.forEach((prod) {
        var categoryJson = prod['category'] as List;

        loadedProducts.add(Product(
          id: prod["id"].toString(),
          titleRu: prod['title_ru'],
          titleKy: prod['title_ky'],
          category: categoryJson.map((categoryJson) => Categories.fromJson(categoryJson)).toList(),
          descriptionKy: prod['description_ky'],
          descriptionRu: prod['description_ru'],
          price: double.parse(prod['price']),
          dealerPrice: double.parse(prod['diller_price']),
          origin: prod['origin'],
          typeOfProduct: prod['type_of_product'],
          productPhoto: prod['image'],
          textKy: prod['text_ky'],
          textRu: prod['text_ru'],
          measureKy: prod['measure_ky'],
          measureRu: prod['measure_ru'],
            typeOfPesticides: prod["type_of_pesticides"]?? null
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }


  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> findByProductType(Categories category, String productType){
    List<Product> typedProd = _items.where((prod) => prod.typeOfProduct == productType).toList();
    List<Product> result = typedProd.where((element){
      return element.category.where((e)=>e.titleRu == category.titleRu).isNotEmpty;
    }).toList();
    return result;
  }
}
