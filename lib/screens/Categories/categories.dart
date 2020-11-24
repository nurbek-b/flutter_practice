import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/providers/categories.dart';
import 'package:shop_app/providers/diseasesPests.dart';
import 'package:shop_app/providers/languages.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/Categories/catGrowingTechnique.dart';
import 'package:shop_app/screens/Categories/diseasesOrPestsItemView.dart';
import 'package:shop_app/screens/Categories/groupedProducts.dart';
import 'package:shop_app/screens/Categories/pesticidesTypes.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
    final appLanguage = Provider.of<AppLanguage>(context).appLocal;
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 45.0,),
            Text(
              AppLocalizations.of(context).translate('all_category'),
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20)),
            ),
            Divider(color: Colors.black),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: 70,
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
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              width: 50,
                              constraints: BoxConstraints(minHeight: 70),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                border: _selectedCat == i ? Border.all(color: Color(0xFF1B5E20)) : Border(),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: [
                                  Container(child: SvgPicture.network(categories[i].icon, height: 30.0, ),),
                                  Container(
                                    // child: Transform.rotate(
                                    //   angle: -pi / 2,
                                    child: Center(
                                      child: appLanguage.toString() == "ru"
                                      ? Text(
                                        "${categories[i].titleRu}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                            color: _selectedCat == i ? Color(0xFF1B5E20) : Colors.black54),
                                      )
                                      : Text(
                                        "${categories[i].titleKy}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                            color: _selectedCat == i ? Color(0xFF1B5E20) : Colors.black54),
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
                  ),
                  Expanded(
                    flex: 8,
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
                                leading: Container(child: SvgPicture.network(categories[_selectedCat].children[index].icon, height: 20.0,)),
                                title: appLanguage.toString() == "ru"
                                ? Text(
                                  "${categories[_selectedCat].children[index].titleRu.toUpperCase()}",
                                  style: TextStyle(
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,),)
                                : Text(
                                  "${categories[_selectedCat].children[index].titleKy.toUpperCase()}",
                                  style: TextStyle(
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,),),
                                /// List of miniCategory
                                children: <Widget>[

                                  ///Технология выращивания продукта
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text(AppLocalizations.of(context).translate('growing_tech'),
                                          style: TextStyle(
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w400,),),
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => GrowingTech(
                                                    // ignore: unrelated_type_equality_checks
                                                    title: appLanguage.toString() == "ru"
                                                    ? "Технология выращивания: ${categories[_selectedCat].children[index].titleRu}"
                                                    : "${categories[_selectedCat].children[index].titleKy} - Өстүүрүү технологиясы",
                                                    // ignore: unrelated_type_equality_checks
                                                    desc: appLanguage == "ky"
                                                    ? categories[_selectedCat].children[index].growingTechniqueRu
                                                    : categories[_selectedCat].children[index].growingTechniqueKy),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  /// Вредители продукта
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text(AppLocalizations.of(context).translate('pests'),
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
                                                    title: appLanguage.toString() == "ru"
                                                        ? "Вредители: ${categories[_selectedCat].children[index].titleRu}"
                                                        : "${categories[_selectedCat].children[index].titleKy} - Зыянкечтери",
                                                    items: pests),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text(AppLocalizations.of(context).translate('diseases'),
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
                                                    title: appLanguage.toString() == "ru"
                                                    ? "Болезни: ${categories[_selectedCat].children[index].titleRu}"
                                                    : "${categories[_selectedCat].children[index].titleKy} - Оруулары",
                                                    items: disease),
                                              ));

                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text(AppLocalizations.of(context).translate("seeds"),
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
                                                    title: appLanguage.toString() == "ru"
                                                        ? "Семена: ${categories[_selectedCat].children[index].titleRu}"
                                                        : "${categories[_selectedCat].children[index].titleKy} - Уруктары",
                                                    items: seeds),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text(AppLocalizations.of(context).translate("fertilizers"),
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
                                                    // ignore: unrelated_type_equality_checks
                                                    title: appLanguage.toString() == "ru"
                                                        ? "Удобрение: ${categories[_selectedCat].children[index].titleRu}"
                                                        : "${categories[_selectedCat].children[index].titleKy} - Жэр семирткичтери",
                                                    items: fertilizers),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(child: GestureDetector(
                                      child: ListTile(
                                        leading: Text(AppLocalizations.of(context).translate("pesticides"),
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
                                                builder: (context) => PesticidesView(
                                                  // ignore: unrelated_type_equality_checks
                                                  title: appLanguage.toString() == "ru"
                                                      ? "Пестициды: ${categories[_selectedCat].children[index].titleRu}"
                                                      : "${categories[_selectedCat].children[index].titleKy} - Пестицидтери",
                                                  products: pesticides),
                                              ),
                                          );
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

