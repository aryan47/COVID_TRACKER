import 'package:corona_tracker/shared/constants.dart';
import 'package:corona_tracker/widgets/MyInheritedWidget.dart';
import 'package:flutter/material.dart';

Widget newsFeed(List<dynamic> data, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: data?.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    removeAllHtmlTags(data[index]['shortDateTime'] ?? ''),
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  ),
                ),
                title: data[index]['subType'] == "quotes"
                    ? Text(
                        removeAllHtmlTags(
                            "\"" + data[index]['title'] + "\"" ?? ''),
                        style: TextStyle(color: COLOR_FONT),
                      )
                    : Text(
                        removeAllHtmlTags(data[index]['title'] ?? ''),
                        style: TextStyle(color: COLOR_FONT),
                      ),
                subtitle: data[index]['subType'] == "quotes"
                    ? Text(
                        "- " +
                            removeAllHtmlTags(
                                data[index]['lbmdescrptionXML'] ?? ''),
                        style: TextStyle(color: COLOR_FONT),
                      )
                    : Text(
                        removeAllHtmlTags(data[index]['smallDesc'] ?? ''),
                        style: TextStyle(color: COLOR_SUB_FONT),
                      ),
              ),
              data[index]['imgUrl'] != null
                  ? Image.network("https://"+data[index]['imgUrl'])
                  : Container()
            ],
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
