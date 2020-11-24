import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Library/carousel_pro/carousel_pro.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/providers/diseasesPests.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/languages.dart';


class DiseaseOrPestItemDetail extends StatefulWidget {
  final DiseaseOrPestItem item;

  DiseaseOrPestItemDetail(this.item);

  @override
  _DiseaseOrPestItemDetailState createState() => _DiseaseOrPestItemDetailState(item);
}

/// Detail Product for Recomended Grid in home screen
class _DiseaseOrPestItemDetailState extends State<DiseaseOrPestItemDetail> {
  /// Declaration List item HomeGridItemRe....dart Class
  final DiseaseOrPestItem item;
  _DiseaseOrPestItemDetailState(this.item);

  @override
  int valueItemChart = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

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
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        // ignore: unrelated_type_equality_checks
        title: Text( appLanguage == "ky"
          ? item.titleRu
          : item.titleKy,
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
                  // Container(
                  //   height: 300.0,
                  //   child: Hero(
                  //     tag: "hero-grid-${item.id}",
                  //     child: Material(
                  //       child: Carousel(
                  //         dotColor: Colors.black26,
                  //         dotIncreaseSize: 1.7,
                  //         dotBgColor: Colors.transparent,
                  //         autoplay: false,
                  //         boxFit: BoxFit.cover,
                  //         images: [],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  /// Background white title,price and ratting
                  // Container(
                  //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  //     BoxShadow(
                  //       color: Color(0xFF656565).withOpacity(0.15),
                  //       blurRadius: 1.0,
                  //       spreadRadius: 0.2,
                  //     )
                  //   ]),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  //     // child: Column(
                  //     //   crossAxisAlignment: CrossAxisAlignment.start,
                  //     //   children: <Widget>[
                  //     //     // Center(
                  //     //     //   child: Text(
                  //     //     //     item.titleRu,
                  //     //     //     style: _customTextStyle,
                  //     //     //   ),
                  //     //     // ),
                  //     //     Padding(padding: EdgeInsets.only(top: 10.0)),
                  //     //     Divider(
                  //     //       color: Colors.black12,
                  //     //       height: 1.0,
                  //     //     ),
                  //     //   ],
                  //     // ),
                  //   ),
                  // ),
                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                AppLocalizations.of(context).translate('disease_description'),
                                style: _subHeaderCustomStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  right: 20.0,
                                  bottom: 10.0,
                                  left: 20.0),
                              // ignore: unrelated_type_equality_checks
                              child: appLanguage == "ky"
                                ? Html(data: item.descriptionRu)
                                : Html(data: item.descriptionKy),
                            ),
                            SizedBox(height: 20.0,),
                            /// Характеристики продукта
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                AppLocalizations.of(context).translate('disease_char'),
                                style: _subHeaderCustomStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0,
                                  bottom: 10.0,
                                  left: 15.0),
                              // ignore: unrelated_type_equality_checks
                              child: appLanguage == "ky"
                                ? Html(data: item.descriptionRu)
                                : Html(data: item.descriptionKy),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

