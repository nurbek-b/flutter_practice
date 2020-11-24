import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/screens/forgot_password/components/newPassBody.dart';


class NewPasswordScreen extends StatelessWidget {
  static String routeName = "/reset_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('forgetPass'),),
      ),
      body: NewPassBody(),
    );
  }
}
