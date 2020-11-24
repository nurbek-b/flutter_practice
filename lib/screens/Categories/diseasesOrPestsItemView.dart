import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/diseasesPests.dart';
import 'package:shop_app/providers/languages.dart';
import 'package:shop_app/screens/details/components/diseasesOrPestsDetail.dart';


class DiseasListByGroup extends StatefulWidget {
  final List<DiseaseOrPestItem> items;
  final String title;

  DiseasListByGroup({this.items, this.title});

  @override
  _DiseasListByGroupState createState() => _DiseasListByGroupState();
}

class _DiseasListByGroupState extends State<DiseasListByGroup> {
  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context).appLocal;
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
                      builder: (ctx) => DiseaseOrPestItemDetail(widget.items[ind]),
                    ),
                  );
                },
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 2.0),
                  title: Container(
                    height: 70,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /// title
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0,),
                                Center(
                                  // ignore: unrelated_type_equality_checks
                                  child: Text( appLanguage == "ky"
                                    ? widget.items[ind].titleRu
                                    : widget.items[ind].titleKy,
                                    style: TextStyle(
                                        fontFamily: "Gotik",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),
                          /// add to favourite iconButton
                        ]),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      /// item counter
                      SizedBox(
                          width:
                          MediaQuery.of(context).size.width * 0.10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
