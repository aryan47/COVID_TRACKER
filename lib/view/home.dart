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
  Map<String, dynamic> countData = {
    'totalConfirmed': 0,
    'totalRecovered': 0,
    "totalDeaths": 0
  };
  List<dynamic> newsData = [];

  @override
  void initState() {
    super.initState();
    fetchCount().then((value) {
      setState(() {
        countData = value;
      });
    });
    fetchNews().then((value) {
      setState(() {
        newsData = value;
      });
    });
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
            height: MediaQuery.of(context).size.height - 140,
            width: MediaQuery.of(context).size.width,
            top: 140,
            child: newsFeed(newsData))
      ],
    );
  }
}
