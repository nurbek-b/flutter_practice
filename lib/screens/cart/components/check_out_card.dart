import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/providers/cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: (40 / 375.0) * mediaQueryData.size.width,
                    width: (40 / 375.0) * mediaQueryData.size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                ],
              ),
            ),
            SizedBox(height: (30 / 812.0) * mediaQueryData.size.height),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: AppLocalizations.of(context).translate('total') + "\n",
                      children: [
                        TextSpan(
                          text: "${cart.totalPrice}",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (190 / 375.0) * mediaQueryData.size.width,
                    height: (50 / 375.0) * mediaQueryData.size.width,
                    child: DefaultButton(
                      text: AppLocalizations.of(context).translate("pay"),
                      press: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
