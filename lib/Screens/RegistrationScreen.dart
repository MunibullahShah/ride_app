import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

class RegistrationScreen extends StatefulWidget {
  var license;
  var selfie;

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 300,
                    child: Center(
                      child: Text(
                        "Registration",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(143, 148, 251, .6),
                          fontSize: 25,
                        ),
                      ),
                    ),
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
                                    color: Color.fromRGBO(143, 148, 251, .2),
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
                                  controller: email,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: number,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone number",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: address,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Address",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
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
                                  controller: pass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Please add an image of your passport/license and a selfie with that passport/license."),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                widget.license == null
                                    ? Container(
                                        height: 100,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Image.file(
                                          widget.license,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.cyanAccent,
                                  ),
                                  onPressed: () {
                                    takeImageDailog(context, 0, 0);
                                  },
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                widget.selfie == null
                                    ? Container(
                                        height: 100,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Image.file(
                                          widget.selfie,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.cyanAccent,
                                  ),
                                  onPressed: () {
                                    takeImageDailog(context, 1, 0);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Lisence"),
                            Text("Selfie"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            takeImageDailog(context, 1, 1);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]),
                            ),
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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

  ///picSelection is for selecting selfie or license
  ///dailogue selection is for selectign pic or agrement dailogue
  takeImageDailog(
      BuildContext context, int picSelection, int dailogueSelection) {
    return showDialog(
        context: context,
        builder: (con) {
          return dailogueSelection == 0
              ? SimpleDialog(
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
                                  _openGallery(context, picSelection);
                                },
                              ),
                              Padding(padding: EdgeInsets.all(8.0)),
                              GestureDetector(
                                child: Text("Camera"),
                                onTap: () {
                                  _openCamera(context, picSelection);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ])
              : SimpleDialog(
                  title: Text(
                    "TERMS & CONDITIONS",
                  ),
                  children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListBody(
                            children: [
                              Text(
                                "1- Contractual Relationship",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "These ITEM JET Terms and Conditions govern your access and use of applications, websites, content, products, and services (the “Services”) made available by ITEM JET, that enable you to arrange and schedule the delivery of package(s) (the “Package(s)”) to a designated city or country (the “Delivery Services”) by independent third party providers of Delivery Services who have an agreement with ITEM JET.\n\nPLEASE READ THE TERMS CAREFULLY PRIOR TO ACCESSING AND USING THE SERVICES, AS THEY CONSTITUTE A LEGAL AGREEMENT BETWEEN YOU AND ITEM JET. We may change these Terms from time to time. We will inform you of changes within a reasonable time period. You will be bound by such changes upon their notification to you. If you do not agree with these changes, you are free to stop using ITEM JET.\n\nBy accessing or using ITEM JET, you confirm your agreement to be bound by ITEM JET Terms of Use. If you do not agree to the ITEM JET Terms of Use, you may not access or use ITEM JET services.\nThe words “including” and “include” mean “including, but not limited to.\"",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "3-  Access to and Use of ITEM JET",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "3.1. This section sets out rights and obligations that apply to your use of ITEM JET. These terms apply in addition to any other rights or obligations set out in the Terms.\n3.2. User Requirements. You may not authorize third parties to use your Account to access and use ITEM JET. You agree to comply with all applicable laws when accessing or using ITEM JET, and you may only access or use ITEM JET for lawful purposes.\n3.3. Prohibited Items. You may not use or access the Delivery Marketplace or use the Delivery Services provided by Third Party Providers to send any Prohibited Items. Prohibited Items include, but are not restricted to:\n •People and animals;\n•Illegal items;\n•Firearms, weapons, ammunition, and their parts;\n•Alcohol;\n•Highly perishable food or beverages (e.g., raw meat or dairy products);\n•Pharmaceutical products, over-the-counter medications, vitamins, or supplements;\n•Cannabis products;\n•Recreational drugs, drug paraphernalia, or tobacco products;\n•Money, gift cards, lottery tickets, or transferable securities;\n•Dangerous or hazardous items, including: explosives, items that are poisonous or flammable (e.g., paints or adhesives containing a flammable liquid);\n•Stolen goods;\n•Fragile items;\n•Sexual aids; obscene or pornographic material;\n•Livestock, regulated species (e.g., plants, noxious weeds, prohibited seeds), or animal parts, bloods, or fluids;\n •Any items for which you do not have permission to send.\n\n ITEM JET retains the discretion to amend the list of Prohibited Items. It is your responsibility to be aware of the current list of Prohibited Items each time you use the ITEM JET request option.\n3.4. Package Restrictions. The Package(s), together, per trip, (i) may not be greater than 14 kilograms (30 pounds) or must not exceed the maximum available weight of the traveler, (ii) must fit comfortably in the hand and the bag of the traveler or the trunk of a mid-size motor vehicle, and (iii) may not have a total value greater than \$100. You must`prepare and securely close and seal the Package(s) for safe delivery.\n3.5. Refusal or Rejection of Deliveries. You acknowledge and agree that the Package(s) are delivered at your request by the Third Party Providers. ITEM JET does not deliver the Package(s). When you order the delivery by Third Party Providers through our Services, you are entering into a contract with a Third Party Provider. The Third Party Providers are free to accept, refuse to pick up or deliver the Package(s) or cancel the delivery of the Package(s) after acceptance for any reason not prohibited by law. If you cancel yourrequest, you will be charged the app usage fees (20% of the price offered by the traveler)\n3.6. Delivery, Redelivery, and Undelivered Package(s). If the Third Party Provider is not able to complete the delivery of a Package, for example because the Third Party Provider is unable to locate the delivery location or no one waiting for him in his delivery destination and is unable to make contact with you or with the recipients, the Third Party Provider may attempt to arrange for the return of the Package to you. If the Third Party Provider is not able to return the Package to you, you acknowledge and agree that the Package may be left at the original pickup location, an alternative location as instructed by you, or at the delivery location or safe place near the delivery location as agreed between you and the Third Party Provider. To the extent feasible and if requested by you, the Services will reasonably permit you to rearrange the delivery with Third Party Providers or facilitate the exchange of the undelivered Package(s) between you and the Third Party Providers. You are responsible to provide all the necessary and useful informations to the traveler to easily find the recipients of your package.\n3.7. Payment. The charges for delivery of the Package(s) in accordance with the ITEM JET Terms of Use will be 20 % of the price offered by the traveler, you acknowledge and agree that this payment be made by you using a digital or electronic payment method.\n3.8. Users must respect airlines rules for overweight and dangerous-good, by using ITEM JET service you agree that ITEM JET is not responsible for any airlines rules or railways or any transportation's institute rules.\n3.9. Travelers must respect the airport customs and any borders rules and their declaration form. ITEM JET are not responsible for any violation of airport laws, the users is the one who bears the full result of violations of laws.",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "4- Limitation of Liability; Indemnity",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "4.1. Nothing in these ITEM JET Terms limits and excludes any liability which cannot legally be limited or excluded, including liability for death or personal injury caused by negligence and liability for fraud or fraudulent misrepresentation, or alter your rights as a consumer that cannot be excluded under applicable law.\n4.2. ITEM JET TOTAL LIABILITY TO YOU FOR USAGE OF ITEM JET SERVICES (and not in relation to any other arrangements between us for which the liability arrangements are governed by way of separate agreement) SHALL NOT EXCEED ONE HUNDRED DOLLARS (\$100).\n 4.3. THE SERVICES AND DELIVERY MARKETPLACE ARE PROVIDED “AS IS” AND “AS AVAILABLE.” ITEM JET disclaims all representations and warranties, express, implied, or statutory, not expressly set out in these Terms, including any implied warranties of merchant ability, fitness for a particular purpose and non-infringement. In addition, ITEM JET makes no representation, warranty, or guarantee regarding the reliability, timeliness, quality, suitability, or availability of the Services, Delivery Marketplace or any services or goods requested through or transported through the use of the Delivery Marketplace, or that the Delivery Marketplace or Services will be uninterrupted or error-free. ITEM JET does not guarantee the quality, suitability, safety or ability of Third Party Providers. You agree that the entire risk arising out of your use of the Services or Delivery Marketplace, and any service or good requested in connection therewith, remains solely with you, to the maximum extent permitted under applicable law.\n 4.4. ITEM JET DOES NOT MAINTAIN INSURANCE FOR LOSS, THEFT, OR DAMAGE CAUSED BY A THIRD PARTY TO THE PACKAGE(S) DELIVERED IN CONNECTION WITH ITEM JET SERVICES. You should contact an insurance agent or broker if insurance coverage is desired in connection with the Package(s) or your use of ITEM JET SERVICES.\n4.5. YOU ASSUME EXPOSURE TO AND RISK OF ANY LOSS, THEFT, TAMPERING OR DELAY IN YOUR USE OF THE SERVICES OR DELIVERY MARKETPLACE. ITEM JET is not liable under or in relation to these Terms including, but not limited to, liability in contract, tort (including negligence, misrepresentation), bailment, restitution or otherwise for any of the following connected to the use of ITEM JET SERVICES: (i) loss of profits; (ii) loss of sales following connected to the use of ITEM JET SERVICES: (i) loss of profits; (ii) loss of sales of use or corruption of software, data or information; (vi) loss of or damage to goodwill, (vii) indirect or consequential loss and (viii) loss, theft, tampering or delay in regards to the Package(s) that you send using ITEM JET\n4.6. ITEM JET is not liable for: (i) damages or losses arising from any transaction between you and a Third Party Provider; or (ii) the availability of the services provided by the Third Party Provider.\n4.7. If you use ITEM JET to arrange delivery of Package(s) not prohibited under these Terms, you assume full responsibility for such Package(s) after delivery, including any damage due to temperature sensitivity and/or tampering.\n4.8. To the extent permitted by law, we exclude all warranties and disclaim all liability for any act or omission by you or any third party.\n4.9. In addition to any indemnity provided in section 5 of the Terms, in respect of your use or access to ITEM JET and your use of delivery services provided by Third Party Providers, you agree to indemnify and hold ITEM JET and its affiliates and their officers, directors, employees, and agents harmless from any and all claims, demands, losses, liabilities, and expenses (including lawyers’ fees), arising out of or in connection with any loss or damage to property, any injury, illness or death to any person, misdelivery including delivery otherwise than to the addressee, delayed delivery, early delivery or failure to deliver or any other loss or damage of any kind caused by your fraudulent, negligent or unlawful act or omission, or any failure by you to comply with the ITEM JET Terms.",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "5- Termination",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "ITEM JET may immediately terminate these Terms or any Services with respect to you, or generally cease offering or deny access to the Services or any portion thereof, at any time for any reason.",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "6- Privacy",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "You agree to comply with applicable privacy and data protection laws relating to your use of ITEM JET, including any laws requiring that you obtain the consent of senders or recipients to the sharing of their personal information with ITEM JET.",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "7- Delivery fees:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "The traveler who determines the delivery price and offer the price to the sender depending on the size of the package and the mode of transportation.\nThe traveler is responsible for setting the price based on the airline rules and airport customs, or based on his means of travel (his vehicle, train or bus…)",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "8- Service fees:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              Text(
                                "The service fees is 20% from the price offered by the traveler, when the traveler offer a price, the price must be included the service fees.",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await register(email.text, ("" + number.text),
                                  pass.text, address.text);
                              Navigator.pop(context);
                            } catch (exception) {
                              print(exception);
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
                                "Agree to Terms and Conditions",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
        });
  }

  _openGallery(BuildContext context, int selection) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      selection == 0 ? widget.license = picture : widget.selfie = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context, int selection) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      selection == 0
          ? widget.license = picture.path
          : widget.selfie = picture.path;
    });
    Navigator.of(context).pop();
  }

  register(String email, String number, String pass, String address) async {
    print(widget.selfie);
    String license64base =
        base64Encode(Io.File(widget.license.path).readAsBytesSync());
    String selfie64base =
        base64Encode(Io.File(widget.selfie.path).readAsBytesSync());
    Map data = {
      "email": email,
      "number": number,
      "pass": pass,
      "lisence": license64base,
      "selfie": selfie64base,
    };
    print("Map: " + data.toString());
    var response = null;
    response = await http.post("https://itemjetc.mywhc.ca/API/register.php",
        body: data);
    print("Hello" + response.statusCode.toString());
    print("response" + response.body);
  }
}
