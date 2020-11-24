import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/providers/cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
          appBar: buildAppBar(context),
          body: cart.items.length > 0
              ? Body()
              : noItemCart(),
          bottomNavigationBar: cart.items.length > 0
              ? CheckoutCard()
              : SizedBox()
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return AppBar(
      title: Column(
        children: [
          Text(
          AppLocalizations.of(context).translate("yourCart"),
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cart.itemCount} + ${AppLocalizations.of(context).translate('products')}",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}


class noItemCart extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return  Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "assets/images/emptyCart.png",
              height: 300.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              AppLocalizations.of(context).translate('cartEmpty'),
              style: TextStyle(
                fontFamily: "Gotik",
                fontWeight: FontWeight.w400,
                fontSize: 18.5,
                color: Colors.black26.withOpacity(0.2),),
            ),
          ],
        ),
      ),
    );
  }
}