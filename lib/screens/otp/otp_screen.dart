import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("codeVerification")),
      ),
      body: Body(),
    );
  }
}
