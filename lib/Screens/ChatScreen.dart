import 'package:flutter/material.dart';
class MessagingScreen extends StatefulWidget {
  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  List<String> messages=[
    "Hello",
    "Hi",
    "How are you?",
    "I am fine\nWhat wbout you?",
    "I am good",
    "This is a little longer message",
    "This is even longer. Next one will be a whole paragraph",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        shadowColor: Color.fromRGBO(37, 145, 212, 1),
        elevation: 15,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){

          },
          icon: Icon(
              Icons.arrow_back_ios,
             color: Colors.black,
          ),
        ),

        title:Text(
            "Username",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>UserDetails()));
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
            ),
          ),
          SizedBox(width: 10,)
        ],

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

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),

        title:Text("Details"),


      ),

      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3,
              child: Center(
                child: Text("Profile picture will appear here"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name of user",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
            ),
            Text(
              "username",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.grey.shade600
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Some other information and desired data of the user will be shown here",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
