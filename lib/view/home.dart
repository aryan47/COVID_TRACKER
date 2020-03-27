import 'package:corona_tracker/shared/constants.dart';
import 'package:corona_tracker/widgets/MyInheritedWidget.dart';
import 'package:corona_tracker/widgets/news_feed.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({this.countData, this.newsData});

  final Map<String, dynamic> countData;
  final List<dynamic> newsData;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  String shareLink = '';
  @override
  void initState() {
    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    MyInheritedWidget.of(context).refresh.add(true);
    await Future.delayed(Duration(seconds: 2));

    return null;
  }

  @override
  Widget build(BuildContext context) {
    shareLink = MyInheritedWidget.of(context).shareLink;
    return RefreshIndicator(
      onRefresh: refreshList,
      child: CustomScrollView(slivers: <Widget>[
     
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                child: newsFeed(widget.newsData, context),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
