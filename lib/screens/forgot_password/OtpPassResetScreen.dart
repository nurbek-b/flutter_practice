import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/screens/forgot_password/components/resetBody.dart';
import 'package:shop_app/size_config.dart';

class OtpPasswordResetScreen extends StatelessWidget {
  static String routeName = "/otp_pass";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('codeVerification')),
      ),
      body: ResetBody(),
    );
  }
}
