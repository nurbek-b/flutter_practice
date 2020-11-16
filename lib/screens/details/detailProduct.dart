import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/Library/carousel_pro/carousel_pro.dart';
import 'package:shop_app/providers/product.dart';
import 'package:flutter/material.dart';


class ProductDetail extends StatefulWidget {
  Product productItem;

  ProductDetail(this.productItem);

  @override
  _ProductDetailState createState() => _ProductDetailState(productItem);
}

/// Detail Product for Recomended Grid in home screen
class _ProductDetailState extends State<ProductDetail> {
  /// Declaration List item HomeGridItemRe....dart Class
  final Product productItem;
  _ProductDetailState(this.productItem);

  @override
  static BuildContext ctx;
  int valueItemChart = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  /// BottomSheet for view more in specification
  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  height: 1500.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Center(
                          child: Text(
                            "Description",
                            style: _subHeaderCustomStyle,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen.",
                            style: _detailText),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Spesifications :",
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              color: Colors.black,
                              letterSpacing: 0.3,
                              wordSpacing: 0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Text(
                          " - Lorem ipsum is simply dummy  ",
                          style: _detailText,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  /// Custom Text black
  static var _customTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  /// Custom Text for Header title
  static var _subHeaderCustomStyle = TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w700,
      fontFamily: "Gotik",
      fontSize: 16.0);

  /// Custom Text for Detail title
  static var _detailText = TextStyle(
      fontFamily: "Gotik",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);

  Widget build(BuildContext context) {
    final formatDecimal = new NumberFormat("###.0#", "en_US");
//    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -0.8),
              children: <Widget>[
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      CupertinoIcons.heart,
                      color: Colors.black26,
                    )),
              ],
            ),
          ),
        ],
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          productItem.titleRu,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontSize: 17.0,
            fontFamily: "Gotik",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// Header image slider
                  Container(
                    height: 300.0,
                    child: Hero(
                      tag: "hero-grid-${productItem.id}",
                      child: Material(
                        child: Carousel(
                          dotColor: Colors.black26,
                          dotIncreaseSize: 1.7,
                          dotBgColor: Colors.transparent,
                          autoplay: false,
                          boxFit: BoxFit.cover,
                          images: [
                            CachedNetworkImage(
                              imageUrl: '${productItem.productPhoto}',
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF1B5E20)),
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /// Background white title,price and ratting
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            productItem.titleRu,
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Text(
                            productItem.price.toString(),
                            style: _customTextStyle,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Divider(
                            color: Colors.black12,
                            height: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 355.0,
                      width: 600.0,
                      decoration:
                      BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Произведено: ${productItem.origin}",
                                  style: _subHeaderCustomStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Описание: ",
                                  style: _subHeaderCustomStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0,
                                    right: 20.0,
                                    bottom: 10.0,
                                    left: 20.0),
                                child: Text(productItem.descriptionRu,
                                    style: _detailText),
                              ),
                              SizedBox(height: 20.0,),

                              /// Характеристики продукта
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Характеристики: ",
                                  style: _subHeaderCustomStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0,
                                    bottom: 10.0,
                                    left: 15.0),
                                child: productItem.textRu == null ? SizedBox() : Html(data:productItem.textRu),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// If user click icon chart SnackBar show
          /// this code to show a SnackBar
          /// and Increase a valueItemChart + 1
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                /// item counter
                Container(
                  width: 140.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(
                          color: Colors.black12.withOpacity(0.1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      /// Decrease of value item
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (productItem.quantity != 1)
                              productItem.quantity --;
                          });
                        },
                        child: Container(
                          height: 50.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.black12
                                          .withOpacity(0.1)))),
                          child: Center(
                              child: Text("-",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF1B5E20)),)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0),
                        child: Text("${formatDecimal.format(productItem.quantity)} ${productItem.measureRu}"),
                      ),

                      /// Increasing value of item
                      InkWell(
                        onTap: () {
                          setState(() {
                            productItem.quantity ++;
                          });
                        },
                        child: Container(
                          height: 50.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: Colors.black12
                                          .withOpacity(0.1)))),
                          child: Center(
                              child: Text("+",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF1B5E20)),)),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                /// add to cart iconButton
                Container(
                    width: 140.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: productItem
                            .addedToCart
                            ? Color(0xFFaddfad)
                            : Color(0xFF1B5E20),
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(
                            color: productItem
                                .addedToCart
                                ? Color(0xFF1B5E20)
                                : Colors.transparent
                        )),
                    child: IconButton(
                      icon: Icon(Icons.shopping_basket),
                      color: productItem.addedToCart ? Color(0xFF1B5E20) : Colors.white, iconSize: 25.0,
                      onPressed: (){
//                        productItem.addedToCart ? cart.removeItem(productItem.id) : cart.addItem(
//                            productItem.id,
//                            productItem.title,
//                            productItem.price,
//                            productItem.description,
//                            productItem.measure,
//                            productItem.quantity,
//                            productItem.productPhoto);
//                        setState(() {productItem.addedToCart = !productItem.addedToCart;});
                      }, )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

