import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/details/detailProduct.dart';


class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
//    final cart = Provider.of<Cart>(context, listen: false);
    return  Card(
        elevation: 2.0,
        margin: new EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 10.0),
        child: Container(
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ProductDetail(product)), );
              },
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                leading: Image.asset('${product.productPhoto}',
                  width: 70,
                  height: 100,
                ),

                title: Container(
                  height: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        /// title, bonus, price
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(product.titleRu),
                              SizedBox(height: 10.0,),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(60.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(3.0, 0.5, 3.0, 0.5),
                                    child: Text(
                                      "${product.origin}",
                                      style: TextStyle(fontSize:10.0),),
                                  )),
                              SizedBox(height: 15.0,),
                              Text("${product.price} c", style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),

                        /// add to favourite iconButton
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: IconButton(
                              onPressed: (){},
                              icon: Icon(product.isFavourite ? CupertinoIcons.heart_solid : CupertinoIcons.heart),
                              color: Color(0xFF1B5E20),
                              iconSize: 20.0,),
                          ),
                        ),
                      ]
                  ),
                ),
                subtitle: Row(
                  children: <Widget>[
                    /// item counter
                    Container(
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: Colors.black12.withOpacity(0.1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                          /// Decrease of value item
                          InkWell(
                            onTap: () {
                              setState(() {
                                  product.quantity -= product.quantity;
                              });
                            },
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.black12
                                              .withOpacity(0.1)))),
                              child: Center(
                                  child: Text("-",
                                    style: TextStyle(
                                        color: Color(0xFF1B5E20)),)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0),
                            child: Text("${product.quantity}"),
                          ),

                          /// Increasing value of item
                          InkWell(
                            onTap: () {
                              setState(() {
                                product.quantity += product.quantity;
                              });
                            },
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.black12
                                              .withOpacity(0.1)))),
                              child: Center(
                                  child: Text("+",
                                    style: TextStyle(
                                        color: Color(0xFF1B5E20)),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                    /// add to cart iconButton
                    Container(
                        width: 80.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF1B5E20),
                          borderRadius: BorderRadius.circular(40.0),),
                        child: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          color: Colors.white, iconSize: 18.0,
                          onPressed: (){
//                            cart.addItem(
//                                product.id,
//                                product.title,
//                                product.price,
//                                product.description,
//                                product.measure,
//                                product.quantity,
//                                product.measureStep,
//                                product.imageUrl);
                          }, )),
                  ],
                ),
                /// Icons add to favourites
              ),
            )
        )
    );
  }
}
