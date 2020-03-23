import 'package:corona_tracker/shared/constants.dart';
import 'package:corona_tracker/widgets/MyInheritedWidget.dart';
import 'package:corona_tracker/widgets/counter.dart';
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
        SliverAppBar(
          expandedHeight: 200,
          floating: true,
          backgroundColor: COLOR_APP_BAR,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.all(0),
            title: null,
            background: ListView(
              children: <Widget>[
                counter(widget.countData, shareLink),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonPadding: EdgeInsets.all(8),
                  children: <Widget>[
                    RaisedButton(
                      elevation: 2.0,
                      color: COLOR_RECOVERED,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        MyInheritedWidget.of(context)
                            .detailsClicked
                            .sink
                            .add(true);
                      },
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RaisedButton(
                      elevation: 2.0,
                      color: COLOR_RECOVERED,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        MyInheritedWidget.of(context)
                            .showGlobalData
                            .sink
                            .add(true);
                      },
                      child: Text(
                        'Global',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: COLOR_APP_BAR,
                child: newsFeed(widget.newsData, context),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
