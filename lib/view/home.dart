import 'dart:developer';

import 'package:corona_tracker/services/news_service.dart';
import 'package:corona_tracker/widgets/counter.dart';
import 'package:corona_tracker/widgets/news_feed.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> countData = {};
  Map<String, dynamic> newsData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCount().then((value) {
      countData = value;
    });
    fetchNews().then((value) {
      newsData = value;
    });
    print(countData);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: counter(countData),
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
