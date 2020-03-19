import 'dart:developer';

import 'package:corona_tracker/widgets/counter.dart';
import 'package:corona_tracker/widgets/news_feed.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: counter(),
        ),
        Positioned(
            height: MediaQuery.of(context).size.height - 80,
            width: MediaQuery.of(context).size.width,
            top: 140,
            child: newsFeed())
      ],
    );
  }
}
