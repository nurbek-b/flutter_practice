import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/categories.dart';

class Product with ChangeNotifier {
  final String id;
  final String titleKy;
  final String titleRu;
  final List<Categories> category;
  final String descriptionKy;
  final String descriptionRu;
  final String productPhoto;
  final double price;
  final double dealerPrice;
  final String origin;
  final String typeOfProduct;
  final String typeOfPesticides;
  final String measureKy;
  final String measureRu;
  final String textKy;
  final String textRu;
  bool isFavourite;
  bool isPopular;
  bool addedToCart;
  double quantity;


  Product({
    this.id,
    this.titleKy,
    this.titleRu,
    this.category,
    this.descriptionKy,
    this.descriptionRu,
    this.productPhoto,
    this.price,
    this.dealerPrice,
    this.origin,
    this.typeOfProduct,
    this.typeOfPesticides,
    this.measureKy,
    this.measureRu,
    this.textKy,
    this.textRu,
    this.isFavourite=false,
    this.isPopular=false,
    this.addedToCart=false,
    this.quantity = 1,
  });


  factory Product.fromJson(dynamic json){
    var categoryJson = json['category'] as List;

    return Product(
        id: json["id"].toString(),
        titleRu: json['title_ru'],
        titleKy: json['title_ru'],
        category: categoryJson.map((categoryJson) => Categories.fromJson(categoryJson)).toList(),
        descriptionKy: json['description_ky'],
        descriptionRu: json['description_ru'],
        price: double.parse(json['price']),
        dealerPrice: double.parse(json['diller_price']),
        origin: json['origin'],
        typeOfProduct: json['type_of_product'],
        productPhoto: json['image'],
        textKy: json['text_ky'],
        textRu: json['text_ru'],
        measureKy: json['measure_ky'],
        measureRu: json['measure_ru'],
        quantity: 1,
        typeOfPesticides:  json["type_of_pesticides"]?? null
    );
  }
}
