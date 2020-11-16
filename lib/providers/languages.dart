import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/storage.dart';


class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('ky');


  Locale get appLocal => _appLocale ?? Locale("ky");


  fetchLocale() async {
    var storage = Storage().secureStorage;
    if (await storage.read(key: 'language_code') == null) {
      _appLocale = Locale('ky');
      return Null;
    }
    _appLocale = Locale(await storage.read(key: 'language_code'));
    return Null;
  }


  void changeLanguage(Locale type) async {
    var storage = Storage().secureStorage;
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ky")) {
      _appLocale = Locale("ky");
      await storage.write(key: 'language_code', value: 'ky');
      await storage.write(key: 'countryCode', value: 'KY');
    } else {
      _appLocale = Locale("ru");
      await storage.write(key: 'language_code', value: 'ru');
      await storage.write(key: 'language_code', value: 'RU');
    }
    notifyListeners();
  }
}