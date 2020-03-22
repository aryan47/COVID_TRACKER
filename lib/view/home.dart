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
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 200,
        floating: false,
        backgroundColor: Colors.grey,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.all(0),
          title: FlatButton.icon(
            padding: EdgeInsets.only(top:12),
              onPressed: null,
              icon: Icon(
                Icons.live_tv,
                color: Colors.red,
              ),
              label: Text('Live')),
          background: ListView(
            children: <Widget>[
              counter(widget.countData),
              Center(
                child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.info_outline),
                    label: Text('Details')),
              )
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              color: Colors.grey,
              child: newsFeed(widget.newsData, context),
            ),
          ],
        ),
      )
    ]);
  }
}
