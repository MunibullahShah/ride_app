import 'package:flutter/material.dart';
import 'package:ride_app/models/request.dart';

class requestCard extends StatefulWidget {
  final RequestModel requestModel;

  const requestCard({
    this.requestModel,
    Key key,
  }) : super(key: key);

  @override
  _requestCardState createState() => _requestCardState();
}

class _requestCardState extends State<requestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 100,
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xffAAAAA8),
            blurRadius: 0,
            offset: Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.circular(4),
        color: Color(0xffF2F2F2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                ///Text for Destination
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 120,
                    height: 28,
                    child: Text(
                      widget.requestModel.from,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(widget.requestModel.description),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.requestModel.weight.toString()),
          ),
        ],
      ),
    );
  }
}
