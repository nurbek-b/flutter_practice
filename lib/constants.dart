import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/size_config.dart';

const kPrimaryColor = Color(0xFF1B5E20);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF4CAF50), Color(0xFF1B5E20)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

/// Regular Expresion for phone number
final RegExp phoneValidatorRegExp =
    RegExp(r'[0-9]{9}');
final String kPhoneNullError = AppLocalizations.instance.translate("phoneEnter");
final String kInvalidPhoneError = AppLocalizations.instance.translate("enterValidNumber");
final String kPassNullError = AppLocalizations.instance.translate("passwordEnter");
final String kShortPassError = AppLocalizations.instance.translate("passwordTooShort");
final String kMatchPassError = AppLocalizations.instance.translate("passwordDismatch");
final String kNameNullError = AppLocalizations.instance.translate("passwordDismatch");
final String kPhoneNumberNullError = AppLocalizations.instance.translate("phoneEnter");
final String kAddressNullError = AppLocalizations.instance.translate("enterAddress");

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
