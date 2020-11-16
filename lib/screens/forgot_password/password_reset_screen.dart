import 'package:flutter/material.dart';
import 'package:shop_app/screens/forgot_password/components/newPassBody.dart';


class NewPasswordScreen extends StatelessWidget {
  static String routeName = "/reset_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Введите пароль"),
      ),
      body: NewPassBody(),
    );
  }
}
