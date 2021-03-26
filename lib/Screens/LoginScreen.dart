import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ride_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'OfferScreen.dart';
import 'RequestScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  String userName;
  String pass;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: isloading == true
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/logo.jpeg'),
                                  fit: BoxFit.fill)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]))),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email or Phone number",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                        onChanged: (value) {
                                          pass = value;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Radio(
                                    value: true,
                                    groupValue: MyApp.isShipper,
                                    onChanged: _account,
                                  ),
                                  Text("Shipper"),
                                  Radio(
                                      value: false,
                                      groupValue: MyApp.isShipper,
                                      onChanged: _account),
                                  Text("Traveller"),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (MyApp.isShipper == null) {
                                    setState(() {
                                      Fluttertoast.showToast(
                                          msg: 'Select Profile',
                                          toastLength: Toast.LENGTH_SHORT);
                                    });
                                  } else {
                                    login(userName, pass);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'registration');
                                },
                                child: Text(
                                  "New user? Register",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }

  void _account(bool value) {
    setState(() {
      MyApp.isShipper = value;
    });
  }

  Future<void> login(String userName, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isloading = true;
    });
    Map data = {
      "email": userName,
      "pass": pass,
    };
    var str = json.encode(data);
    try {
      var response = null;
      response = await http.post(
        "https://itemjetc.mywhc.ca/API/login.php",
        headers: {"Content-Type": "application/json"},
        body: str,
      );
      if (response.statusCode == 200) {
        Map res = jsonDecode(response.body);
        sharedPreferences.setString("ID", res['ID']);
        if (res['code'] != -1) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => MyApp.isShipper == true
                      ? OffersScreen()
                      : RequestScreen()),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            isloading = false;
            Fluttertoast.showToast(
                msg: 'Check email/password', toastLength: Toast.LENGTH_SHORT);
          });
        }
      }
    } on TimeoutException catch (e) {
      setState(() {
        isloading = false;
        Fluttertoast.showToast(
            msg: 'Unable to connect', toastLength: Toast.LENGTH_SHORT);
      });
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      setState(() {
        isloading = false;
        Fluttertoast.showToast(
            msg: 'Unable to connect', toastLength: Toast.LENGTH_SHORT);
      });
      print('Socket Error: $e');
    } on Error catch (e) {
      setState(() {
        isloading = false;
        Fluttertoast.showToast(
            msg: 'Unable to connect', toastLength: Toast.LENGTH_SHORT);
      });
      print('General Error: $e');
    }
  }
}
