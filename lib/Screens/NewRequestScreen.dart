import 'dart:async';
import 'dart:convert';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

import 'package:shared_preferences/shared_preferences.dart';

class NewRequestScreen extends StatefulWidget {
  @override
  _NewRequestScreenState createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  String dropDownValue = '1';
  int weight;
  String fromLocation = "";
  String toLocation = "";
  var image;
  String description;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController discriptionController;
    return SafeArea(
      child: Scaffold(
        body: isloading == true
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
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
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          style: TextStyle(),
                          maxLines: 2,
                          onChanged: (value) {
                            description = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description'),
                          controller: discriptionController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              image == null
                                  ? Container(
                                      height: 100,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ]),
                                      ),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.file(
                                        image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                              IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.cyanAccent,
                                ),
                                onPressed: () {
                                  dailogCreation(context);
                                },
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            value: dropDownValue,
                            onChanged: (String newValue) {
                              setState(() {
                                dropDownValue = newValue;
                                weight = int.parse(dropDownValue);
                                print(weight);
                              });
                            },
                            items: <String>[
                              '1',
                              '2',
                              '3',
                              '4',
                              '4',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10',
                              '11',
                              '12',
                              '13',
                              '14',
                              '15',
                              '16',
                              '17',
                              '18',
                              '19',
                              '20',
                              '21',
                              '22',
                              '23',
                              '24',
                              '25',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Text("kg"),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          newRequest();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  dailogCreation(BuildContext context) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
              title: Text(
                "Item Image",
              ),
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListBody(
                      children: [
                        GestureDetector(
                          child: Text("Gallery"),
                          onTap: () {
                            _openGallery(context);
                          },
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        GestureDetector(
                          child: Text("Camera"),
                          onTap: () {
                            _openCamera(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ]);
        });
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      image = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      image = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> newRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String image64base = base64Encode(Io.File(image.path).readAsBytesSync());
    setState(() {
      isloading = true;
    });
    Map data = {
      "User": sharedPreferences.getString('ID'),
      "Start": fromLocation,
      "End": toLocation,
      "Weight": weight.toString(),
      "Description": description,
      "Image": image64base,
    };
    String str = json.encode(data);
    try {
      var response = await http.post(
        "https://itemjetc.mywhc.ca/API/request.php",
        headers: {"Content-Type": "application/json"},
        body: str,
      );
      if (response.statusCode == 200) {
        Map res = jsonDecode(response.body);
        if (res['code'] != -1) {
          print(response.body);
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Request submitted successfully",
              toastLength: Toast.LENGTH_SHORT);
        }
      }
    } on TimeoutException catch (e) {
      setState(() {
        isloading = false;
        Fluttertoast.showToast(
            msg: 'Unable to connect', toastLength: Toast.LENGTH_SHORT);
      });
      print('Timeout Error: $e');
    } on Io.SocketException catch (e) {
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
