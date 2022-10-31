import 'dart:io';

import 'package:flutter/material.dart';
import 'package:princess/AppTheme.dart';
import 'package:princess/Provider/offer_provider.dart';
import 'package:provider/provider.dart';

import 'Config/Routes.dart';
import 'Provider/AuthProvider.dart';
import 'Provider/MainProvider.dart';
import 'Views/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  runApp(
    new MyApp(),
  );
}

class MyApp extends StatefulWidget {
  static String type = "";
  static String email = "";
  static int Id = 0;
  static String name = "";

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setState(() {
      //  appPushNotifications.notificationSetup(navKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MainProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OfferProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
      ],
      child: MaterialApp(
        /* localizationsDelegates: translator.delegates,
          locale: local,
          supportedLocales: translator.locals(),*/

        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
        home: Splash(),
        theme: ThemeData(
          primaryColor: AppTheme.primaryColor,
          accentColor: AppTheme.primaryColor,
          fontFamily: "helveticaneuelt",
          /*   textTheme: TextTheme(
                bodyText1: TextStyle(),
                bodyText2: TextStyle(),
              ).apply(
                bodyColor: textColor,
                displayColor: Colors.blue,
              )*/
        ),
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
