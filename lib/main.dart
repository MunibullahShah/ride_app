import 'package:flutter/material.dart';
import 'package:ride_app/Screens/OrderScreen.dart';
import 'package:ride_app/Screens/OfferScreen.dart';

import 'Screens/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OffersScreen(),
    );
  }
}
