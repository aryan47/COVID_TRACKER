import 'package:flutter/material.dart';

Widget newsFeed() {
  return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: 111,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Hello hi how are you, i have been searching you for so long', style: TextStyle(color: Colors.red),),
        );
      });
}
