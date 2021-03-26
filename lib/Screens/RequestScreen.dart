import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:ride_app/models/request.dart';
import 'package:ride_app/widgets/RequestCard.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String fromLocation = "%";
  List<RequestModel> requests;
  double bid;

  Future<void> data(fromLocation) async {
    Map data = {
      "Start": fromLocation,
      "End": "%",
    };
    var str = json.encode(data);
    await http
        .post(
      "https://itemjetc.mywhc.ca/API/search.php",
      headers: {"Content-Type": "application/json"},
      body: str,
    )
        .then(
      (value) {
        processList(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (requests == null) {
      requests = List<RequestModel>();
      data(fromLocation);
    }
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'setting');
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'setting');
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Setting",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'support');
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.contact_support,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Support",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(
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
            Container(
              height: MediaQuery.of(context).size.height - 238,
              child: GestureDetector(
                onTap: () {},
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                            child: requestCard(
                              requestModel: requests[index],
                            ),
                            onTap: () {
                              _dailogCreation(context);
                            },
                          );
                        },
                        childCount: requests.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Post an offer"),
          icon: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(43, 61, 145, 1),
          focusColor: Color.fromRGBO(42, 163, 220, .6),
          onPressed: () {
            Navigator.pushNamed(context, 'new Offer');
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int) {
            if (int == 0) {
              Navigator.pushNamed(context, "offer");
            }
            if (int == 1) {
              Navigator.pushNamed(context, 'request');
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined,
                  color: Color.fromARGB(255, 0, 0, 0)),
              title: new Text(
                'Offers',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.request_page_outlined,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: new Text('Requests'))
          ],
        ),
      ),
    );
  }

  void processList(http.Response value) {
    var receivedData = json.decode(value.body);
    for (int i = 0; i < receivedData.length; i++) {
      RequestModel model = RequestModel(
        receivedData[i]['data']['Start'],
        receivedData[i]['data']['End'],
        int.parse(receivedData[i]['data']['ID']),
        int.parse(receivedData[i]['data']['Weight']),
        receivedData[i]['data']['Description'],
        receivedData[i]['data']['Image'],
      );
      requests.add(model);
    }
    setState(() {});
  }

  _dailogCreation(BuildContext context) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Offer",
            ),
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListBody(
                    children: [
                      Text("Make your Bid"),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          bid = value as double;
                        },
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      GestureDetector(
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
                              "Bid",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
