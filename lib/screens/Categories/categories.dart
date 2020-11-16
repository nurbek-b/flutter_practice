import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/categories.dart';
import 'package:shop_app/providers/diseasesPests.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/Categories/catGrowingTechnique.dart';
import 'package:shop_app/screens/Categories/diseasesOrPestsItemView.dart';
import 'package:shop_app/screens/Categories/groupedProducts.dart';
import 'package:shop_app/screens/Categories/pesticidesTypes.dart';

class CategoriesScreen extends StatefulWidget {
  static String routeName = "/allCategories";
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedCat = 0;
  int selected = null;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit){
      Provider.of<Categories>(context).fetchAndSetCategories();
      Provider.of<Products>(context).fetchAndSetProducts();
      Provider.of<Diseases>(context).fetchAndSetDiseasesPests();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).categories;
//    final productsData = Provider.of<Products>(context).items;
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5.0,),
            Text(
              "Все категории",
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    margin: const EdgeInsets.only(right: 15),
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (ctx, i) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCat = i;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 25.0),
                            // padding: const EdgeInsets.symmetric(vertical: 45.0),
                            width: 50,
                            constraints: BoxConstraints(minHeight: 101),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: _selectedCat == i ? Border.all() : Border(),
                              color: _selectedCat == i
                                  ? Colors.transparent
                                  : Color(0xFF1B5E20),
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            // child: Transform.rotate(
                            //   angle: -pi / 2,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Text(
                                "${categories[i].titleRu}",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(
                                    color: _selectedCat == i
                                        ? Color(0xFF1B5E20)
                                        : Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      /// List of middleCategory
                      child: categories.length == 0
                          ? SizedBox()
                          : ListView.builder(
                        key: Key('builder ${selected.toString()}'),
                        itemCount: categories[_selectedCat].children.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            padding: const EdgeInsets.all(9.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ListTileTheme(
                              iconColor: Color(0xFF00AB50),
                              selectedColor: Color(0xFF00AB50),
                              dense: true,
                              child: ExpansionTile(
                                key: Key(index.toString()), /// Attention
                                initiallyExpanded : index==selected, /// Attention
                                onExpansionChanged: ((newState){
                                  if(newState)
                                    setState(() {
                                      Duration(seconds:  20000);
                                      selected = index;
                                    });
                                  else setState(() {
                                    selected = -1;
                                  });
                                }),
                                title: Text(
                                  "${categories[_selectedCat].children[index].titleRu}",
                                  style: TextStyle(
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,),),
                                /// List of miniCategory
                                children: <Widget>[

                                  ///Технология выращивания продукта
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text("   Технология выращивания",
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => GrowingTech(
                                                    title: "Технология выращивания: ${categories[_selectedCat].children[index].titleRu}",
                                                    desc: categories[_selectedCat].children[index].growingTechniqueRu),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  /// Вредители продукта
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text("   Вредители",
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          List pests = Provider.of<Diseases>(context, listen: false)
                                              .findByDiseasesPestsType('pests', categories[_selectedCat].children[index]);
                                          print("PESTS $pests");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DiseasListByGroup(
                                                    title: "Вредители: ${categories[_selectedCat].children[index].titleRu}",
                                                    items: pests),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text("   Болезни",
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          List disease = Provider.of<Diseases>(context, listen: false)
                                              .findByDiseasesPestsType('disease', categories[_selectedCat].children[index] );
                                          print("DISEASES $disease");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DiseasListByGroup(
                                                    title: "Болезни: ${categories[_selectedCat].children[index].titleRu}",
                                                    items: disease),
                                              ));

                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text("   Семена",
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          List seeds = Provider.of<Products>(context, listen: false)
                                              .findByProductType(categories[_selectedCat].children[index], 'seeds');
                                          print("SEEDS $seeds");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ListByGroup(
                                                    title: "Семена: ${categories[_selectedCat].children[index].titleRu}",
                                                    items: seeds),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text("   Удобрение",
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          List fertilizers = Provider.of<Products>(context, listen: false)
                                              .findByProductType(categories[_selectedCat].children[index], 'fertilizers');
                                          print("FERTILISERS $fertilizers");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ListByGroup(
                                                    title: "Удобрение: ${categories[_selectedCat].children[index].titleRu}",
                                                    items: fertilizers),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text("   Пестициды",
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          List<Product> pesticides = Provider.of<Products>(context, listen: false)
                                              .findByProductType(categories[_selectedCat].children[index], 'pesticides');
                                          print("PESTICIDES $pesticides");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Catalogue(
                                                  title: "Пестициды: ${categories[_selectedCat].children[index].titleRu}",
                                                  products: pesticides),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

