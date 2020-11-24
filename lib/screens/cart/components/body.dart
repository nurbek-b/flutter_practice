import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: (20 / 375.0) * mediaQueryData.size.width),
      child: ListView.builder(
        itemCount: cart.itemCount,
        itemBuilder: (context, index){
          String id = cart.items.keys.elementAt(index);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  cart.removeItem(cart.items[index].id.toString());
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: cart.items[id]),
            ),
          );
        },
      ),
    );
  }
}
