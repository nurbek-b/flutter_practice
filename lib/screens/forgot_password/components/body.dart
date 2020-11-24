import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/forgot_password/OtpPassResetScreen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/storage.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                AppLocalizations.of(context).translate('forgetPass'),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('sendOtpForgetPass'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String phone;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue){
              return phone = "+996$newValue";},
            onChanged: (value) {
              /// has to been changed for phone errors
              if (value.isNotEmpty && errors.contains(kPhoneNullError)) {
                setState(() {
                  errors.remove(kPhoneNullError);
                });
                /// need to change regex for phone number
              }
              else if (phoneValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidPhoneError)) {
                setState(() {
                  errors.remove(kInvalidPhoneError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kPhoneNullError)) {
                setState(() {
                  errors.add(kPhoneNullError);
                });
              }
              else if (!phoneValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidPhoneError)) {
                setState(() {
                  errors.add(kInvalidPhoneError);
                });
              }
              return null;
            },
            maxLength: 9,
            decoration: InputDecoration(
              prefixText: "+996",
              labelText: AppLocalizations.of(context).translate('phoneNumber'),
              hintText: AppLocalizations.of(context).translate('phoneEnter'),
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: AppLocalizations.of(context).translate('proceed'),
            press: ()async{
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                auth.resetPassword(phone: phone);
                await Storage().secureStorage.write(key: "phone", value: phone);
                Navigator.pushNamed(context, OtpPasswordResetScreen.routeName);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
