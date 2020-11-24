import 'package:flutter/foundation.dart';
import 'package:shop_app/storage.dart';

class cartItem{
  String id;
  String titleRu;
  String titleKy;
  double price;
  double dealerPrice;
  int quantity;
  String measureRu;
  String measureKy;
  String descriptionRu;
  String descriptionKy;
  String productPhoto;

  cartItem({
    this.id,
    this.titleRu,
    this.titleKy,
    this.price,
    this.dealerPrice,
    this.descriptionRu,
    this.descriptionKy,
    this.measureRu,
    this.measureKy,
    this.quantity,
    this.productPhoto,
  });

}


class Cart with ChangeNotifier{
  var storage = Storage().secureStorage;

  Map<String, cartItem> _items = {};

  Map<String, cartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void deleteItems() {
    _items.clear();
    notifyListeners();
  }

  void addItem(
      String id,
      String titleRu,
      String titleKy,
      double price,
      String descriptionRu,
      String descriptionKy,
      String measureRu,
      String measureKy,
      int quantity,
      String productPhoto,) {
    if (_items.containsKey(id)) {
      // change quantity...
      _items.update(id, (existingCartItem) =>
          cartItem(
            id: existingCartItem.id,
            titleRu: existingCartItem.titleRu,
            titleKy: existingCartItem.titleKy,
            price: existingCartItem.price,
            productPhoto: existingCartItem.productPhoto,
            measureRu: existingCartItem.measureRu,
            measureKy: existingCartItem.measureKy,
            descriptionRu: existingCartItem.descriptionRu,
            descriptionKy: existingCartItem.descriptionKy,
            quantity: existingCartItem.quantity + 1,
          ),
      );
    } else {
      _items.putIfAbsent(
        id,
            () =>
            cartItem(
              id: id,
              titleRu: titleRu,
              titleKy: titleKy,
              price: price,
              productPhoto: productPhoto,
              measureRu: measureRu,
              measureKy: measureKy,
              descriptionRu: descriptionRu,
              descriptionKy: descriptionKy,
              quantity: quantity,
            ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }

    if (_items[id].quantity > 1) {
      // reduce quantity...

      _items.update(
        id,(existingCartItem) =>
          cartItem(
            id: existingCartItem.id,
            titleRu: existingCartItem.titleRu,
            titleKy: existingCartItem.titleKy,
            price: existingCartItem.price,
            productPhoto: existingCartItem.productPhoto,
            measureRu: existingCartItem.measureRu,
            measureKy: existingCartItem.measureKy,
            descriptionRu: existingCartItem.descriptionRu,
            descriptionKy: existingCartItem.descriptionKy,
            quantity: existingCartItem.quantity - 1,
          ),);
    } else {
      _items.remove(id);
    }

    notifyListeners();
  }


  void addSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    _items.update(
      productId,(existingCartItem) =>
        cartItem(
          id: existingCartItem.id,
          titleRu: existingCartItem.titleRu,
          titleKy: existingCartItem.titleKy,
          price: existingCartItem.price,
          productPhoto: existingCartItem.productPhoto,
          measureRu: existingCartItem.measureRu.toString(),
          measureKy: existingCartItem.measureKy.toString(),
          descriptionRu: existingCartItem.descriptionRu,
          descriptionKy: existingCartItem.descriptionKy,
          quantity: existingCartItem.quantity + 1,
        ),);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart(){
    _items = {};
    notifyListeners();
  }

}