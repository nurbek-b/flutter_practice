import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/storage.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phone = Storage().secureStorage.read(key: "phone");
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                AppLocalizations.of(context).translate("codeVerification"),
                style: headingStyle,
              ),
              Text(AppLocalizations.of(context).translate("weSendMessage") + "$phone"),
              buildTimer(),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () async{
                  final phone = await Storage().secureStorage.read(key: "phone");
                  final password = await Storage().secureStorage.read(key: "password");
                  final passwordConfirm = await Storage().secureStorage.read(key: "passwordConfirm");
                  await Provider.of<Auth>(context, listen: false)
                      .register(phone: phone, password: password,
                      passwordConfirm: passwordConfirm);
                },
                child: Text(
                  AppLocalizations.of(context).translate("sendMoreMessage"),
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.instance.translate('codeExpires')),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
