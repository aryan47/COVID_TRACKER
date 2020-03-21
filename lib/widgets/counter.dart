import 'package:corona_tracker/shared/constants.dart';
import 'package:flutter/material.dart';

import 'common_widget.dart';

Widget counter(Map<String,dynamic> data){
  return ListView(
    shrinkWrap: true,
      children: <Widget>[
        title(data['displayName']),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            cardCount(data['totalConfirmed'].toString(), CONST_ACTIVE),
            cardCount(data['totalRecovered'].toString(), CONST_RECOVERED),
            cardCount(data["totalDeaths"].toString(), CONST_FATAL),
          ],
        )
      ],
    );
}