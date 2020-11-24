import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:suspense/suspense.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app_localizations.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/categories.dart';
import 'package:shop_app/providers/diseasesPests.dart';
import 'package:shop_app/providers/languages.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:shop_app/storage.dart';
import 'package:shop_app/widgets/bottomNavBar.dart';

String access;

Future<void> main()async {
  AppLanguage appLanguage = AppLanguage();
  WidgetsFlutterBinding.ensureInitialized();
  await appLanguage.fetchLocale();
  access = await Storage().secureStorage.read(key: 'access');
  runApp(MyApp(appLanguage: appLanguage,));
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _calculation = Future.delayed(Duration(seconds: 3), () => true);
  final _calculation2 = Future.delayed(Duration(seconds: 120), () => true);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AppLanguage()),
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProvider.value(value: Products()),
          ChangeNotifierProvider.value(value: Diseases()),
          ChangeNotifierProvider.value(value: Categories()),
        ],
      child: Consumer2<Auth, AppLanguage>(
          builder: (ctx, auth, language, _) => MaterialApp(
            locale: language.appLocal,
            supportedLocales: [
              Locale('ky'),
              Locale('ru'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Агриматко',
            theme: theme(),
            routes: routes,
            home: Suspense(
              future: access != null ? _calculation : _calculation2,
              fallback: access != null ? Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 250.0,),
                      Image.asset("assets/main_page/logo.jpg"),
                    ],
                  ),
                ),) : SplashScreen(),
              builder: (_) => BottomNavBar(),
              errorBuilder: (error) =>
                  Text("Unknown error ERROR ${error.toString()}"),
            ),
          )
        ),
      );
  }
}
