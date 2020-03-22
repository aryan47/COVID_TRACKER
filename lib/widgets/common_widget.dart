import 'package:corona_tracker/shared/constants.dart';
import 'package:flutter/material.dart';

Widget title(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Text(
        text ?? '',
        softWrap: false,
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget cardCount(String data, String status) {
  final card = new Container(
    height: 70.0,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            status,
            style: TextStyle(color: getStatusColor(status)),
          ),
        ),
        Text(
          data,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
    decoration: new BoxDecoration(
      color: new Color(0xFF333366),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );
  return card;
}

Color getStatusColor(String status) {
  Color color;
  if (status == CONST_ACTIVE) {
    color = COLOR_ACTIVE;
  } else if (status == CONST_RECOVERED) {
    color = COLOR_RECOVERED;
  } else if (status == CONST_FATAL) {
    color = COLOR_FATAL;
  }
  return color;
}
