import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/forgot_password/components/otp_form_reset_password.dart';
import 'package:shop_app/size_config.dart';


class ResetBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phone = Provider.of<Auth>(context).phone;
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
                AppLocalizations.of(context).translate('codeVerification'),
                style: headingStyle,
              ),
              Text(AppLocalizations.of(context).translate("weSendMessage") + "$phone"),
              buildTimer(),
              OtpPasswordForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
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
