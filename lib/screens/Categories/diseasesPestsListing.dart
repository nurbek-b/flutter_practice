import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/details/detailProduct.dart';


class DiseasesPests extends StatefulWidget {
  final List<Product> items;
  final String title;

  DiseasesPests({this.items, this.title});

  @override
  _DiseasesPestsState createState() => _DiseasesPestsState();
}

class _DiseasesPestsState extends State<DiseasesPests> {
  @override
  Widget build(BuildContext context) {
   final cart = Provider.of<Cart>(context, listen: false);
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
          style: TextStyle(
              fontFamily: "Gotik",
              fontWeight: FontWeight.w400,
              color: Color(0xFF1B5E20)),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.items.toList().length,
        itemBuilder: (BuildContext context, int ind) {
          return Padding(
            padding: const EdgeInsets.only(
                top: 5.0, left: 13.0, right: 13.0, bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 3.5,
                    spreadRadius: 0.4,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ProductDetail(
                          widget.items[ind]),
                    ),
                  );
                },
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 2.0),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 400,
                      maxWidth: 100,
                      maxHeight: 400,
                    ),
                    child: CachedNetworkImage(
                      width: 100,
                      height: 100,
                      imageUrl:
                      '${widget.items[ind].productPhoto}',
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF1B5E20),
                            ),
                            strokeWidth: 2.0,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  ),
                  title: Container(
                    height: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /// title, origin, price
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 12.0,),
                                Text(
                                  widget.items[ind].titleRu,
                                  style: TextStyle(
                                      fontFamily: "Gotik",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${widget.items[ind].price} c",
                                  style: TextStyle(
                                      fontFamily: "Gotik",
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      /// item counter
                      Container(
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.black12.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            /// Decrease of value item
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (widget.items[ind].quantity != 1)
                                    widget.items[ind].quantity --;
                                });
                              },
                              child: Container(
                                height: 20.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.black12
                                          .withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        fontFamily: "Gotik",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1B5E20),
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0),
                              child: Text(
                                "${widget.items[ind].quantity} ${widget.items[ind].measureRu}",
                                style: TextStyle(
                                  fontFamily: "Gotik",
                                  fontWeight: FontWeight.w400,
                                ),),
                            ),

                            /// Increasing value of item
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.items[ind].quantity ++;
                                });
                              },
                              child: Container(
                                height: 30.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.black12
                                          .withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        fontFamily: "Gotik",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1B5E20)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width:
                          MediaQuery.of(context).size.width * 0.10),

                      /// add to cart iconButton
                      Container(
                        width: 60.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                            color: widget.items[ind]
                                .addedToCart
                                ? Color(0xFFaddfad)
                                : Color(0xFF1B5E20),
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: widget.items[ind]
                                    .addedToCart
                                    ? Color(0xFF1B5E20)
                                    : Colors.transparent)),
                        child: IconButton(
                          icon: Icon(Icons.shopping_basket),
                          color: widget.items[ind]
                              .addedToCart
                              ? Color(0xFF1B5E20)
                              : Colors.white,
                          iconSize: 20.0,
                          onPressed: () async {
                           widget.items[ind].addedToCart
                               ? cart.removeItem(widget.items[ind].id)
                               : cart.addItem(
                               widget.items[ind].id,
                               widget.items[ind].titleRu,
                               widget.items[ind].titleKy,
                               widget.items[ind].price,
                               widget.items[ind].descriptionRu,
                               widget.items[ind].descriptionKy,
                               widget.items[ind].measureRu,
                               widget.items[ind].measureKy,
                               widget.items[ind].quantity,
                               widget.items[ind].productPhoto);
                           setState(() {
                             widget.items[ind].addedToCart = !widget.items[ind].addedToCart;
                           });
                          },
                        ),
                      ),
                    ],
                  ),
                  /// Icons add to favourites
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
