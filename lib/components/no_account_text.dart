import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/screens/sign_in/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).translate('noProfile?'),
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        SizedBox(width: 20.0,),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
          AppLocalizations.of(context).translate('registration'),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
