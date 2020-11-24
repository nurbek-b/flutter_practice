import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('auth')),
      ),
      body: Body(),
    );
  }
}
