import 'package:flutter/material.dart';
import 'package:ride_app/Screens/NewOfferScreen.dart';
import 'package:ride_app/Screens/NewRequestScreen.dart';
import 'package:ride_app/Screens/OfferScreen.dart';
import 'package:ride_app/Screens/RequestScreen.dart';
import 'package:ride_app/Screens/SupportScreen.dart';

import 'Screens/LoginScreen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  ///True for shipper and false for traveller
  static bool isShipper;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "login",
      routes: {
        "login": (context) => LoginScreen(),
        "request": (context) => RequestScreen(),
        'offer': (context) => OffersScreen(),
        'support': (context) => SupportScreen(),
        'new Request': (context) => NewRequestScreen(),
        'new Offer': (context) => NewOfferScreen(),
      },
    );
  }
}
