import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/home/home.dart';
import 'package:shop_app/screens/info_page/info_page.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/nestedNavigator.dart';

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBarState createState() => new _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
      CartScreen(),
      ProfilePage(),
    ],
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blueGrey,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(color: Color(0xFF1B5E20)),
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
              icon: Icon(CupertinoIcons.home, size: 28.0),
              title: Container()),
          BottomNavigationBarItem(
              icon: Consumer<Cart>(
                builder: (_, cart, ch){
                  return Badge(child: ch, value: cart.itemCount.toString());},
                child: IconButton(
                  icon: Icon(CupertinoIcons.shopping_cart,
                  size: 28.0,
                  color: _indexBar == 1
                    ? Color(0xFF1B5E20)
                    : Colors.blueGrey))),
                title: Container()),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled, size: 28.0),
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