import 'package:corona_tracker/shared/constants.dart';
import 'package:flutter/material.dart';

import 'common_widget.dart';

Widget counter(Map<String, dynamic> data) {
  return ListView(
    shrinkWrap: true,
    children: <Widget>[
      title(data['displayName'] ?? ''),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          cardCount(
              data['totalConfirmed'] != null
                  ? data['totalConfirmed'].toString()
                  : '0',
              CONST_ACTIVE),
          cardCount(
              data['totalRecovered'] != null
                  ? data['totalRecovered'].toString()
                  : '0',
              CONST_RECOVERED),
          cardCount(
              data["totalDeaths"] != null
                  ? data["totalDeaths"].toString()
                  : '0',
              CONST_FATAL),
        ],
      )
    ],
  );
}
