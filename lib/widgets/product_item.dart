import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/languages.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/details/detailProduct.dart';


class ProductItem extends StatefulWidget {
  final Product item;

  ProductItem({Key key, @required this.item}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool addedToCart;

  @override
  void initState() {
    super.initState();
    addedToCart = widget.item.addedToCart;
  }

  void toggleAddedToCart(Product item) {
    setState((){
      addedToCart = !addedToCart;
      item.addedToCart = addedToCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatDecimal = new NumberFormat("###.0#", "en_US");
    final appLanguage = Provider.of<AppLanguage>(context).appLocal;
    final cart = Provider.of<Cart>(context, listen: false);
    return Padding(
      padding:
      const EdgeInsets.only(top: 5.0, left: 13.0, right: 13.0, bottom: 5.0),
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
                builder: (ctx) => ProductDetail(widget.item),
              ),
            );
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            leading: CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: '${widget.item.productPhoto}',
              placeholder: (context, url) => Center(
                child: SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1B5E20)),
                    strokeWidth: 2.0,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // ignore: unrelated_type_equality_checks
                          Text(appLanguage.toString() == "ru"
                            ? widget.item.titleRu
                            : widget.item.titleKy,
                            style: TextStyle(
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            "${formatDecimal.format(widget.item.price)} c",
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      /// Decrease of value item
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.item.quantity != 1)
                              widget.item.quantity --;
                          });
                        },
                        child: Container(
                          height: 30.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.black12.withOpacity(0.1),
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
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(appLanguage.toString() == "ru"
                            ? "${widget.item.quantity} ${widget.item.measureRu}"
                            : "${widget.item.quantity} ${widget.item.measureKy}",
                          style: TextStyle(
                            fontFamily: "Gotik",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      /// Increasing value of item
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.item.quantity ++;
                          });
                        },
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.black12.withOpacity(0.1),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B5E20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.10),

                /// add to cart iconButton
                Container(
                    width: 60.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      color: addedToCart
                          ? Color(0xFFaddfad)
                          : Color(0xFF1B5E20),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                          color: addedToCart ? Color(0xFF1B5E20) : Colors.transparent),
                    ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.shopping_basket),
                      color: addedToCart ? Color(0xFF1B5E20) : Colors.white,
                      iconSize: 20.0,
                      onPressed: () {
                        addedToCart
                            ? cart.removeItem(widget.item.id)
                            : cart.addItem(
                            widget.item.id,
                            widget.item.titleRu,
                            widget.item.titleKy,
                            widget.item.price,
                            widget.item.descriptionRu,
                            widget.item.descriptionKy,
                            widget.item.measureRu,
                            widget.item.measureKy,
                            widget.item.quantity,
                            widget.item.productPhoto);
                        setState((){
                          toggleAddedToCart(widget.item);
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
