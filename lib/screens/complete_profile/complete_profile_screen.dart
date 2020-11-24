import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('registration'),),
      ),
      body: Body(),
    );
  }
}
