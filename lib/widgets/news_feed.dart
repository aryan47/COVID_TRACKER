import 'package:corona_tracker/shared/constants.dart';
import 'package:corona_tracker/widgets/MyInheritedWidget.dart';
import 'package:flutter/material.dart';

Widget newsFeed(List<dynamic> data, BuildContext context) {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    MyInheritedWidget.of(context).refresh.add(true);
    await Future.delayed(Duration(seconds: 2));

    return null;
  }

  return RefreshIndicator(
    onRefresh: refreshList,
    child: ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: data?.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Text(
                removeAllHtmlTags(data[index]['shortDateTime'] ?? ''),
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
            ),
            title: Text(
              removeAllHtmlTags(data[index]['title'] ?? ''),
              style: TextStyle(color: COLOR_FONT),
            ),
            subtitle: Text(
              removeAllHtmlTags(data[index]['smallDesc'] ?? ''),
              style: TextStyle(color: COLOR_SUB_FONT),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.black);
      },
    ),
  );
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
