import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/Categories/categories.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/widgets/bottomNavBar.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String phone;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate('signUpError'),
            style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.5,
        )),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('proceed'),
              style: TextStyle(color: kPrimaryColor),),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, ForgotPasswordScreen.routeName),
            child: Text(
              AppLocalizations.of(context).translate("forgetPass"),
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: AppLocalizations.of(context).translate('proceed'),
            press: ()async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await Provider.of<Auth>(context, listen: false).logIn(
                    phone: phone,
                    password: password).then((value){
                  if(value.statusCode == 200 ){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    );
                  }else{
                    _showErrorDialog(AppLocalizations.of(context).translate("noUserWithNum"),);
                  }
                });
              }
            }
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate("password"),
        hintText: AppLocalizations.of(context).translate("passwordEnter"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = "+996$newValue",
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        } else if (phoneValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidPhoneError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNullError);
          return "";
        } else if (!phoneValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidPhoneError);
          return "";
        }
        return null;
      },
      maxLength: 9,
      decoration: InputDecoration(
        prefixText: "+996",
        labelText: AppLocalizations.of(context).translate("phoneNumber"),
        hintText: AppLocalizations.of(context).translate("phoneEnter"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
