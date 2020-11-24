import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/languages.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';


class PesticidesView extends StatefulWidget {
  final String title;
  final List<Product> products;

  PesticidesView({Key key, this.title, this.products}) : super(key: key);

  @override
  _PesticidesViewState createState() => _PesticidesViewState();
}

class _PesticidesViewState extends State<PesticidesView> {
  List<String> pesticidesType = ["herbicides", "fungicides", "insecticides", "acaricides"];
  List<String> usedTypes = [];

  @override
  void initState() {
    widget.products.forEach((element) {
      if(pesticidesType.contains(element.typeOfPesticides)){
        switch(element.typeOfPesticides){
          case "herbicides":
            usedTypes.add("Гербициды");
            break;
          case "fungicides":
            usedTypes.add("Фунгициды");
            break;
          case "insecticides":
            usedTypes.add("Инсектициды");
            break;
          case "acaricides":
            usedTypes.add("Акарициды");
            break;
        }
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).items;
    return Scaffold(
      body: DefaultTabController(
        length: usedTypes.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Text(
                  widget.title.toString(),
                  style: TextStyle(
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1B5E20)),
                ),
                floating: true,
                pinned: true,
                snap: true,
                // <--- this is required if I want the application bar to show when I scroll up
                bottom: new TabBar(
                    isScrollable: true,
                    indicatorColor: Color(0xFF1B5E20),
                    labelColor: Color(0xFF1B5E20),
                    labelPadding: EdgeInsets.all(8.0),
                    unselectedLabelColor: Colors.black,
                    tabs: [for (var item in usedTypes)
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Text(
                          item,
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                        ),
                      )
                    ] // <-- total of 2 tabs
                ),
              ),
            ];
          },
          body: TabBarView(
              children: [for (int i = 0; i < usedTypes.length; i++)
                    ListView.builder(
                    itemCount: productsData.where((item) => item.typeOfPesticides == widget.products[i].typeOfPesticides).toList().length,
                    itemBuilder: (context, index) {
                      var item = productsData.where((item) => item.typeOfPesticides == widget.products[i].typeOfPesticides).toList()[index];
                      return ProductItem(item: item);
                    })
              ]
          ),
        ),
      ),
    );
  }
}
