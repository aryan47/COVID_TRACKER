import 'dart:async';

import 'package:corona_tracker/shared/constants.dart';
import 'package:corona_tracker/widgets/MyInheritedWidget.dart';
import 'package:corona_tracker/widgets/app_upgrade.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'services/news_service.dart';
import 'view/country_list.dart';
import 'view/home.dart';

import 'package:get_version/get_version.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

void main() {
  if (!kIsWeb) _setTargetPlatformForDesktop();
  return runApp(MyInheritedWidget(child: MyApp()));
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

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
  String _projectVersion = '';

  DatabaseReference databaseReference;
  String countApi;
  String newsApi;
  String selectedCountry;
  String latestAppVersion;
  String playStoreUrl;
  BehaviorSubject loading;
  int loadedApiCount = 0;
  Map<String, dynamic> countData = {
    'totalConfirmed': 0,
    'totalRecovered': 0,
    "totalDeaths": 0
  };
  Map<String, dynamic> selectedData = {};
  List<dynamic> newsData = [];
  List<dynamic> country = [];
  bool appStarted = false;
  bool lockUpdate = false;
  @override
  void initState() {
    _initPlatformState();

    super.initState();

    loading = BehaviorSubject.seeded(false);
    loading.stream.listen((event) {
      if (event) {
        loadedApiCount += 1;
      }
      if (loadedApiCount == 2) {
        loadedApiCount = 0;
        setState(() {
          appStarted = true;
        });
      }
    });
    initiateApiCall();

    // refresh the api link
    Timer.periodic(Duration(seconds: FIREBASE_API_REFRESH_SEC), (timer) {
      initiateApiCall();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyInheritedWidget.of(context).refresh.stream.listen((event) {
      if (event) {
        initiateApiCall();
      }
    });
  }

  void initiateApiCall() {
    databaseReference = FirebaseDatabase.instance.reference();
    fetchApis(databaseReference).then((value) {
      print('initiate api call --------');

      countApi = value['COUNT_API'];
      newsApi = value['NEWS_API'];
      latestAppVersion = value['LATEST_APP_VERSION'];
      playStoreUrl = value['PLAY_STORE_URL'];

      countApiCall(countApi);
      newsApiCall(newsApi);
    });
  }

  void newsApiCall(value) {
    print('fetch api call --------');
    fetchNews(value).then((value) {
      loading.sink.add(true);
      setState(() {
        newsData = value;
      });
    });
  }

  void countApiCall(value) {
    print('count api call --------');
    fetchCount(value).then((value) {
      loading.sink.add(true);
      country = value['areas'].map((value) => value['displayName']).toList();
      setState(() {
        countData = value;
        selectedData = new Map.from(countData);
        changeContext(selectedCountry ?? 'India');
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _initPlatformState() async {
    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _projectVersion = projectVersion;
  }

  @override
  Widget build(BuildContext context) {
    if (appStarted && !lockUpdate) {
      lockUpdate = true;
      Future.delayed(
          Duration.zero,
          () => checkAppVersion(
              _projectVersion, latestAppVersion, context, playStoreUrl));
      Timer.periodic(Duration(minutes: 30), (timer) {
        Future.delayed(
            Duration.zero,
            () => checkAppVersion(
                _projectVersion, latestAppVersion, context, playStoreUrl));
      });
    }

    return Scaffold(
      body: appStarted
          ? Home(countData: selectedData, newsData: newsData)
          : Center(child: CircularProgressIndicator()),
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
    selectedCountry = selected;
    if (selected.isNotEmpty) {
      setState(() {
        selectedData = countData['areas']
            .where((value) => value['displayName'] == selected)
            .toList()[0];
      });
    }
  }
}
