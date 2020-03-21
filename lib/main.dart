import 'dart:async';

import 'package:corona_tracker/shared/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'services/news_service.dart';
import 'view/country_list.dart';
import 'view/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'COVID Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference databaseReference;
  String countApi;
  String newsApi;
  Map<String, dynamic> countData = {
    'totalConfirmed': 0,
    'totalRecovered': 0,
    "totalDeaths": 0
  };
  Map<String, dynamic> selectedData = {};
  List<dynamic> newsData = [];
  List<dynamic> country = [];
  @override
  void initState() {
    super.initState();
    initiateApiCall();

    // refresh the api link
    Timer.periodic(Duration(hours: FIREBASE_API_REFRESH_HR), (timer) {
      initiateApiCall();
    });

    // refresh the count and news api
    Timer.periodic(Duration(seconds: COUNT_AND_NEWS_API_REFRESH_SEC), (timer) {
      countApiCall(countApi);
      newsApiCall(newsApi);
    });
  }

  void initiateApiCall() {
    databaseReference = FirebaseDatabase.instance.reference();

    fetchApis(databaseReference).then((value) {
      print('initiate api call --------');

      countApi = value['count_api'];
      newsApi = value['news_api'];

      countApiCall(countApi);
      newsApiCall(newsApi);
    });
  }

  void newsApiCall(value) {
    print('fetch api call --------');
    fetchNews(value).then((value) {
      setState(() {
        newsData = value;
      });
    });
  }

  void countApiCall(value) {
    print('count api call --------');
    fetchCount(value).then((value) {
      country = value['areas'].map((value) => value['displayName']).toList();
      setState(() {
        countData = value;
        selectedData = new Map.from(countData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(countData: selectedData, newsData: newsData),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Country(country: country)),
          ).then((value) {
            changeContext(value);
          });
        },
        tooltip: 'List',
        child: Icon(Icons.menu),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changeContext(String selected) {
    setState(() {
      selectedData = countData['areas']
          .where((value) => value['displayName'] == selected)
          .toList()[0];
    });
  }
}
