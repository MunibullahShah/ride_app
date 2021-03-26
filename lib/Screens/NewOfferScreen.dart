import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

class NewOfferScreen extends StatefulWidget {
  @override
  _NewOfferScreenState createState() => _NewOfferScreenState();
}

class _NewOfferScreenState extends State<NewOfferScreen> {
  String fromLocation;
  String toLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("From"),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    SelectState(
                      // style: TextStyle(color: Colors.red),
                      onCountryChanged: (value) {
                        setState(() {
                          fromLocation = "$value, ";
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          fromLocation = "$fromLocation$value, ";
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          fromLocation = "$fromLocation$value";
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("To"),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SelectState(
                      // style: TextStyle(color: Colors.red),
                      onCountryChanged: (value) {
                        setState(() {
                          toLocation = "$value, ";
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          toLocation = "$fromLocation$value, ";
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          toLocation = "$fromLocation$value";
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(43, 61, 145, 1),
                        Color.fromRGBO(42, 163, 220, .6),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
