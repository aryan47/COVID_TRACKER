import 'package:corona_tracker/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'common_widget.dart';

Widget counter(Map<String, dynamic> data, String shareLink) {
  return ListView(
    shrinkWrap: true,
    children: <Widget>[
      Stack(
        children: <Widget>[
          title(data['displayName'] ?? ''),
          Align(
            alignment: Alignment.topRight,
            child: FlatButton.icon(
              padding: EdgeInsets.only(right: 0),
              onPressed: () {
                Share.share(shareLink);
              },
              icon: Icon(
                Icons.share,
                color: Colors.red,
              ),
              label: Text('Share'),
            ),
          ),
        ],
      ),
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
