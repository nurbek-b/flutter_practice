import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/Categories/categories.dart';
import 'package:shop_app/screens/home/home.dart';
import 'package:shop_app/screens/info_page/info_page.dart';
import 'package:shop_app/widgets/nestedNavigator.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexBar = 0;

  PageController _pageController = PageController(initialPage: 0);

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  PageView pageViewBuilder(ctx) => PageView(
    controller: _pageController,
    onPageChanged: (val) {
      setState(() {
        _indexBar = val;
      });
    },
    children: <Widget>[
      HomePage(),
      CategoriesScreen(),
      Container(
        child: Center(
          child: Text(
            'Favourites',
          ),
        ),
      ),
      ProfilePage(),
    ],
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blueGrey,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(color: Color(0xFF00AB50)),
        currentIndex: _indexBar,
        onTap: (val) {
          setState(() {
            _indexBar = val;
            while (navigationKey.currentState.canPop()) {
              navigationKey.currentState.pop();
            }
            _pageController.animateToPage(val,
                duration: Duration(milliseconds: 700),
                curve: Curves.easeInOut);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home, size: 23.0),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.collections), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled, size: 24.0),
              title: Container()),
        ],
      ),
      body: NestedNavigator(
        navigationKey: navigationKey,
        initialRoute: '/',
        routes: {'/': pageViewBuilder},
      ),
    );
  }
}