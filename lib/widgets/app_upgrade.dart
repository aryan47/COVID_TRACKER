import 'package:corona_tracker/services/common_service.dart';
import 'package:flutter/material.dart';

Future<void> checkAppVersion(String oldVersion, String latestVersion,
    BuildContext context, String playStoreUrl) async {
  bool show = false;
  if (oldVersion.isNotEmpty && latestVersion.isNotEmpty) {
    // if latestVersion is greater than oldVersion
    if (oldVersion.compareTo(latestVersion) == -1) {
      show = true;
    }
  }

  if (show) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New update available'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please update the app'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Update'),
              onPressed: () {
                Navigator.of(context).pop();
                launchURL(playStoreUrl);
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  return null;
}
