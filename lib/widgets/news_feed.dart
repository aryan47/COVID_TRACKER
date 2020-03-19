import 'package:flutter/material.dart';

Widget newsFeed() {
  return ListView.separated(
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemCount: 111,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Text('8:00 AM'),
        title: Text(
          'Hello hi how are you, i have been searching you for so long',
          style: TextStyle(color: Colors.red),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider(
        color: Colors.black
      );
    },
  );
}
