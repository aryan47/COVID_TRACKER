import 'dart:developer';

import 'package:corona_tracker/services/news_service.dart';
import 'package:corona_tracker/widgets/counter.dart';
import 'package:corona_tracker/widgets/news_feed.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Map<String,dynamic> countData;
  List<dynamic> newsData;

  Home({this.countData, this.newsData});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: counter(widget.countData),
        ),
        Positioned(
            height: MediaQuery.of(context).size.height - 140,
            width: MediaQuery.of(context).size.width,
            top: 140,
            child: newsFeed(widget.newsData))
      ],
    );
  }
}
