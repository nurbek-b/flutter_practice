import 'package:flutter/material.dart';
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
const String kPhoneNullError = "Введите номер телефона";
const String kInvalidPhoneError = "Введите валидный номер";
const String kPassNullError = "Введите пароль";
const String kShortPassError = "Пароль слишком короткий";
const String kMatchPassError = "Пароли не совпадают";
const String kNameNullError = "Введите имя";
const String kPhoneNumberNullError = "Введите номер телефона";
const String kAddressNullError = "Введите адрес";

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
