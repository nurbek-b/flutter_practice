import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/storage.dart';

String mainUrl = "http://agrimatico-backend.ml/";

class Auth with ChangeNotifier{
  String _access;
  String _refresh;
  String _userId;
  String _name;
  String _phone;
  String _password;
  bool isEditing = false;

  Auth(){
    this.refresh();
  }

  void refresh() async {
    var storage = Storage().secureStorage;
    storage.read(key: "access").then((value) => this._access = value);
    storage.read(key: "name").then((value) => this._name = value);
    storage.read(key: "phone").then((value) => this._phone = value);
    notifyListeners();
  }

  bool get isAuth =>this._access != null;

  String get name => this._name ?? "Ваше имя";

  set name(String value) {
    _name = value;
  }

  String get phone => this._phone;

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Ошибка"),
    content: Text("Пользователь с таким номером уже существует."),
    actions: [
        FlatButton(
          child: Text("Далее"),
          onPressed: () { },),
    ],
  );

  Future register({String phone, String password, String passwordConfirm})async{
    var storage = Storage().secureStorage;
    final authUrl = "${mainUrl}api/v1/accounts/register/";
    try {
      final res = await http.post(
        authUrl,
        body: jsonEncode({
          "phone": phone,
          "password": password,
          "password_confirmation": passwordConfirm}),
        headers: { "Content-Type": "application/json; charset=UTF-8"},
      );
      final responseData = jsonDecode(res.body);
      print("THIS IS FROM REGISTER");
      print(responseData);
      await storage.write(key: "phone", value: phone);
      await storage.write(key: "password", value: password);
      await storage.write(key: "passwordConfirm", value: passwordConfirm);
      return responseData;
    }catch (error){
      print(error);
      throw error;
    }
  }

  Future logIn({String phone, String password, String userType})async{
    var storage = Storage().secureStorage;
    final authUrl = "${mainUrl}api/v1/accounts/login/";
    try {
      final res = await http.post(
        authUrl,
        body: jsonEncode({
          "phone": phone,
          "password": password,
          "user_type": "customer"}),
        headers: { "Content-Type": "application/json; charset=UTF-8"},);
      final responseData = jsonDecode(res.body);
      print("FIRST RESPONSE $responseData}");
      await storage.write(key: "phone", value: phone);
      await storage.write(key: "password", value: password);
      await storage.write(key: "userType", value: userType);
      await storage.write(key: "access", value: responseData['access']);
      await storage.write(key: "refresh", value: responseData['refresh']);
      print("PHONE $phone");
      print("PASSWORD $password");
      print("RESPONSE $res");
      return res;
    }catch (error){
      print("ERROR $error");
      throw error;
    }
  }



  Future resetPassword({String phone})async{
    var storage = Storage().secureStorage;
    final resetUrl = "${mainUrl}api/v1/accounts/password_reset/";
    try {
      final res = await http.post(
        resetUrl,
        body: jsonEncode({"phone": phone.toString()}),
        headers: { "Content-Type": "application/json; charset=UTF-8"},);
      final responseData = json.decode(utf8.decode(res.bodyBytes));
      print("PASSWORD $responseData");
      await storage.write(key: "otpNumber", value: phone);
      return res;
    }catch (error){
      throw error;
    }
  }



  Future setOTP({String otpNum, String phone})async{
    var storage = Storage().secureStorage;
    final otpUrl = "${mainUrl}api/v1/accounts/password_reset_confirmation/";
    try{
      final res = await http.post(
          otpUrl,
          body: jsonEncode({
            "phone": phone,
            "activation_code": otpNum.toString()}),
          headers: { "Content-Type": "application/json; charset=UTF-8"},
      );
      print("OTP $otpNum");
      print("NUMBER $phone");
      final responseData = json.decode(utf8.decode(res.bodyBytes));
      print("RESPONSE FROM OTP $responseData");
      // await storage.write(key: "userId", value: responseData["id"]);
      // await storage.write(key: 'refresh', value: responseData['refresh']);
      // await storage.write(key: 'access', value: responseData['access']);
      // this._userId = await storage.read(key: 'userId');
      // this._refresh = await storage.read(key: 'refresh');
      // this._access = await storage.read(key: 'access');
      return res;
    }catch(error){
      throw error;
    }
  }


  Future setNewPassword({String newPassword1, String newPassword2, String phone})async{
    var storage = Storage().secureStorage;
    final otpUrl = "${mainUrl}api/v1/accounts/password_reset_confirmation_done/";
    try{
      final res = await http.post(
        otpUrl,
        body: jsonEncode({
          "phone": phone,
          "new_password1": newPassword1,
          "new_password2": newPassword2}),
        headers: { "Content-Type": "application/json; charset=UTF-8"},
      );
      print("NUMBER $phone");
      print("newPassword1 $newPassword1");
      print("newPassword1 $newPassword1");
      final responseData = json.decode(utf8.decode(res.bodyBytes));
      print("RESPONSE FROM NEW PASSWORD $responseData");
      // await storage.write(key: "userId", value: responseData["id"]);
      // await storage.write(key: 'refresh', value: responseData['refresh']);
      // await storage.write(key: 'access', value: responseData['access']);
      // this._userId = await storage.read(key: 'userId');
      // this._refresh = await storage.read(key: 'refresh');
      // this._access = await storage.read(key: 'access');
      return res;
    }catch(error){
      throw error;
    }
  }

  void logout(){
    Storage().secureStorage.deleteAll();
    this._access = null;
    this._name = null;
    this._phone = null;
    this._refresh = null;
    this._userId = null;
    this._password = null;
  }

}