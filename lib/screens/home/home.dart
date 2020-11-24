import 'package:flutter/material.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/screens/Categories/categories.dart';


class HomePage extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100.0,),
              Text(AppLocalizations.of(context).translate('skot'), style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
              SizedBox(height: 15.0,),
              InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset('assets/main_page/cow.jpeg',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.60),
                ),
              ),
              SizedBox(height: 40.0,),
              Text(AppLocalizations.of(context).translate('agronom'), style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
              SizedBox(height: 15.0,),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset('assets/main_page/mainagri.jpeg',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.60),
                ),
              ),
            ],
          ),
        )
    );
  }
}
