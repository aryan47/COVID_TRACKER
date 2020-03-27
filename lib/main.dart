import 'dart:async';

import 'package:corona_tracker/shared/constants.dart';
import 'package:corona_tracker/view/details.dart';
import 'package:corona_tracker/view/loading_screen.dart';
import 'package:corona_tracker/widgets/MyInheritedWidget.dart';
import 'package:corona_tracker/widgets/app_upgrade.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';

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
  int _currentIndex = 0;
  DatabaseReference databaseReference;
  String countApi;
  String newsApi;
  String selectedCountry;
  String latestAppVersion;
  String playStoreUrl;
  String appShareLink;
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
      if (loadedApiCount == 1) {
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
      // countApi = value['COUNT_API'];
      newsApi = value['NEWS_API'];
      latestAppVersion = value['LATEST_APP_VERSION'];
      playStoreUrl = value['PLAY_STORE_URL'];
      appShareLink = value['APP_SHARE_LINK'];

      // countApiCall(countApi);
      newsApiCall(newsApi);
    });
  }

  void newsApiCall(value) {
    fetchNews(value).then((value) {
      loading.sink.add(true);
      setState(() {
        newsData = value;
      });
    });
  }

  // void countApiCall(value) {
  //   fetchCount(value).then((value) {
  //     loading.sink.add(true);
  //     country = value['areas'].map((value) => value['displayName']).toList();
  //     setState(() {
  //       countData = value;
  //       selectedData = new Map.from(countData);
  //       changeContext(selectedCountry ?? 'India');
  //     });
  //   });
  // }

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
    // save app sharelink
    MyInheritedWidget.of(context).shareLink = appShareLink;

    if (appStarted && !lockUpdate) {
      lockUpdate = true;
      Future.delayed(
          Duration.zero,
          () => checkAppVersion(
              _projectVersion, latestAppVersion, context, playStoreUrl));
      Timer.periodic(Duration(minutes: 10), (timer) {
        Future.delayed(
            Duration.zero,
            () => checkAppVersion(
                _projectVersion, latestAppVersion, context, playStoreUrl));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Live News'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Share.share(appShareLink);
            },
            child: Text(
              'Share',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: appStarted
          ? Home(countData: selectedData, newsData: newsData)
          : LoadingScreen(),
      // bottomNavigationBar: appStarted
      //     ? BottomNavigationBar(
      //         backgroundColor: Colors.grey[100],
      //         onTap: (int index) {
      //           _currentIndex = index;
      //           switch (index) {
      //             case 0:
      //               detailsPage();
      //               break;
      //             case 1:
      //               countryList();
      //               break;
      //             case 2:
      //               changeContext('Global');
      //               break;
      //           }
      //         },
      //         currentIndex:
      //             _currentIndex, // this will be set when a new tab is tapped
      //         items: [
      //           BottomNavigationBarItem(
      //             icon: new Icon(Icons.more),
      //             title: new Text('More'),
      //           ),
      //           BottomNavigationBarItem(
      //             icon: new Icon(Icons.list),
      //             title: new Text('Country'),
      //           ),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.rounded_corner), title: Text('Global'))
      //         ],
      //       )
      //     : Container(),
    );
  }

  // void changeContext(String selected) {
  //   selectedCountry = selected;
  //   if (selected != null && selected.isNotEmpty && selected == "Global") {
  //     setState(() {
  //       selectedData = Map.from(countData);
  //     });
  //   } else if (selected != null && selected.isNotEmpty) {
  //     setState(() {
  //       selectedData = countData['areas']
  //           .where((value) => value['displayName'] == selected)
  //           .toList()[0];
  //     });
  //   }
  // }

  // void countryList() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Country(country: country)),
  //   ).then((value) {
  //     changeContext(value);
  //   });
  // }

  // void detailsPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => Details(areas: selectedData['areas'] ?? [])),
  //   ).then((value) {
  //     changeContext(value);
  //   });
  // }
}
