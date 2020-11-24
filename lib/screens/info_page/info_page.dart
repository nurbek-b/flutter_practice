import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/providers/languages.dart';
import 'package:shop_app/screens/info_page/EditProfilePage.dart';
import 'package:shop_app/utils/list_profile_section.dart';
import 'package:shop_app/utils/CustomTextStyle.dart';
import 'package:shop_app/utils/CustomUtils.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ProfilePage extends StatefulWidget {
  static String routeName = "/profile_page";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ListProfileSection> listSection = new List();

  static List<String> imgList = [
    "assets/images/image-10.jpeg",
    "assets/images/image-10.jpeg",
    "assets/images/image-10.jpeg",
    "assets/images/image-10.jpeg",
    "assets/images/image-10.jpeg",
  ];

  @override
  void initState() {
    super.initState();
  }

  static List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(100, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();


  Container imageSlider() {
    return Container(
        child: Column(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              aspectRatio: 10.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
        ],
        ));
  }

  createSection(String title, String icon, Color color, Widget widget) {
    return ListProfileSection(title, icon, color, widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Utils.getSizedBox(height: 50),
          buildHeader(),
          Utils.getSizedBox(height: 24),
          imageSlider(),
          Utils.getSizedBox(height: 24),
          /// orders
          Builder(builder: (context) {
            return InkWell(
              splashColor: Colors.teal.shade200,
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.only(top: 14, left: 24, right: 8, bottom: 14),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: Color(0xFF1B5E20)),
                      child: Image(
                        image: AssetImage("assets/images/ic_payment.png"),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppLocalizations.of(context).translate('orderHistory'),
                        style: CustomTextStyle.textFormFieldMedium,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          /// contact
          Builder(builder: (context) {
            return InkWell(
              splashColor: Colors.teal.shade200,
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.only(top: 14, left: 24, right: 8, bottom: 14),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: Color(0xFF1B5E20)),
                      child: Image(
                        image: AssetImage("assets/images/ic_about_us.png"),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppLocalizations.of(context).translate('contact'),
                        style: CustomTextStyle.textFormFieldMedium,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          /// dealers orders
          Builder(builder: (context) {
            return InkWell(
              splashColor: Colors.teal.shade200,
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.only(top: 14, left: 24, right: 8, bottom: 14),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: Color(0xFF1B5E20)),
                      child: Image(
                        image: AssetImage("assets/images/ic_payment.png"),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppLocalizations.of(context).translate('dillerOrderHistory'),
                        style: CustomTextStyle.textFormFieldMedium,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          /// logout
          Builder(builder: (context) {
            return InkWell(
              splashColor: Colors.teal.shade200,
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                setState(() {});
                AlertDialog(
                  content: Text(AppLocalizations.of(context).translate('youExited'),),
                );
              },
              child: Container(
                padding: EdgeInsets.only(top: 14, left: 24, right: 8, bottom: 14),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: Color(0xFF1B5E20)),
                      child: Image(
                        image: AssetImage("assets/images/ic_logout.png"),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppLocalizations.of(context).translate('logout'),
                        style: CustomTextStyle.textFormFieldMedium,
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Container buildHeader() {
    final language = Provider.of<AppLanguage>(context);
    return Container(
          child: Consumer2<Auth, AppLanguage>(
            builder: (ctx, auth, locale, _) => Row(
              children: <Widget>[
              Utils.getSizedBox(width: 14),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /// Enter or change phone number and name
                    auth.isAuth
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(auth.name,
                          textAlign: TextAlign.start,
                          style: CustomTextStyle.textFormFieldBlack
                              .copyWith(color: Color(0xFF1B5E20), fontSize: 14),
                        ),
                        Utils.getSizedBox(height: 2),
                        Text(auth.phone == null ?  AppLocalizations.instance.translate('phoneNumber') : auth.phone,
                          style: CustomTextStyle.textFormFieldMedium
                              .copyWith(color: Color(0xFF1B5E20), fontSize: 12),
                        ),
                      ],
                    )
                        : SizedBox(),
                    auth.isAuth
                        ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        )
                        : SizedBox(),
                    SizedBox(width: 60.0,),
                    /// Language change config
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton(
                        icon: Icon(Icons.language, color: Color(0xFF1B5E20),),
                        items: [
                          DropdownMenuItem(
                            onTap: (){
                              language.changeLanguage(Locale("ky"));
                            },
                            value: Locale( 'ky' ),
                            child: Text( 'кыргызча'),),
                          DropdownMenuItem(
                              onTap: (){
                                language.changeLanguage(Locale("ru"));
                              },
                              value: Locale( 'ru' ),
                              child: Text( 'русский' )),
                        ],
                        onChanged: (v) => setState(() { locale.changeLanguage( v );}),
                        value: locale.appLocal,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          ),
        );
      }

}