import 'package:corona_tracker/shared/constants.dart';
import 'package:flutter/material.dart';

import 'common_widget.dart';

Widget counter(){
  return ListView(
    shrinkWrap: true,
      children: <Widget>[
        title("Global Status"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            cardCount('1234', CONST_ACTIVE),
            cardCount('1234', CONST_RECOVERED),
            cardCount('1234', CONST_FATAL),
          ],
        )
      ],
    );
}