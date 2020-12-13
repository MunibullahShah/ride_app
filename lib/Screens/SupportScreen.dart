import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  List<String> openTickets=[
    "This is a ticket",
    "This is another ticket",
    "This is third ticket",
  ];
  List<String> openTimes=[
    "09/12/2020",
    "11/19/2020",
    "22/02/2020",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20,),

              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("asset/logo.jpeg")
                  )
                ),
              ),

              Text(
                "How can we help you?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              FlatButton(
                onPressed: ()async{
                  try{
                    await launch("mailto:example@example.org?subject=Support&body=New%20plugin");
                  }catch(e){
                    
                  }
                },
                child: Text(
                  "Wite an email?",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 1.2,
                    color: Colors.blue
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Live chat",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveSupport()));
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Open Tickets",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5,),
                        ListTile(
                          leading: Text("ID"),
                          title: Text("Description"),
                          trailing: Text("Date"),
                          tileColor: Colors.grey.shade400,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: openTickets.length,
                            itemBuilder: (context,index){
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Text(index.toString()),
                                    title: Text(openTickets[index]),
                                    trailing: Text(openTimes[index]),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveSupport()));
                                    },
                                    tileColor: Colors.grey.shade300,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                    height: 1,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
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

class LiveSupport extends StatefulWidget {
  @override
  _LiveSupportState createState() => _LiveSupportState();
}

class _LiveSupportState extends State<LiveSupport> {
  List<String> messages=[
    "Hi, How can we help you?",
    ];
  List<String> times=[
    "11:10",
    "11:20",
    "13:05",
    "01:10",
    "02:10",
    "05:10",
    "11:10",
    "11:10",
    "07:10",
    "02:10",
  ];
  List<bool> sender=[
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        shadowColor: Color.fromRGBO(37, 145, 212, 1),
        elevation: 15,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),

        title:Text(
          "Item Jet Support",
          style: TextStyle(
              color: Colors.black
          ),
        ),


      ),
      body: Container(
        child: Column(
          children: [

            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount:messages.length,
                itemBuilder: (context,index){
                  return messageBox(messages[(messages.length-1)-index], times[index], sender[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(37, 145, 212, 1),
                            blurRadius: 5
                        ),
                      ]
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height:50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(37, 145, 212, 1),
                                    blurRadius: 2
                                ),
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "   Write your message here",
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 5,),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(37, 145, 212, 1),
                                  Color.fromRGBO(32, 41, 127, 1)
                                ]
                            ),
                          ),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.send,color: Colors.white,),
                          ),
                        ),
                      ),

                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageBox(String message, String time, bool sent){
    return Padding(
      padding: sent?
      const EdgeInsets.fromLTRB(60, 10, 10, 15)
          :
      const EdgeInsets.fromLTRB(10, 10, 60, 15),
      child: Container(
        decoration: BoxDecoration(
          //color: sent?Color.fromRGBO(37, 145, 212, 1):Color.fromRGBO(32, 41, 127, 1),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: sent?[
                  Color.fromRGBO(37, 145, 212, 1),
                  Color.fromRGBO(32, 41, 127, 1)
                ]
                    :
                [
                  Color.fromRGBO(32, 41, 127, 1),
                  Color.fromRGBO(37, 145, 212, 1),
                ]
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: sent?Radius.circular(10):Radius.circular(0),
              topRight: Radius.circular(10),
              bottomRight: sent?Radius.circular(0):Radius.circular(10),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Align(
                alignment: sent?Alignment.centerRight:Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),

              Align(
                alignment: !sent?Alignment.centerRight:Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5,0,5,0),
                  child: Text(
                    time,
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 12,
                        letterSpacing: 1.1
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

