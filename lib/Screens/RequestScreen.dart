import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Requests will be shown here",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Post an offer"),
          icon: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(43, 61, 145, 1),
          focusColor: Color.fromRGBO(42, 163, 220, .6),
          onPressed: () {},
        ),
      ),
    );
  }
}
