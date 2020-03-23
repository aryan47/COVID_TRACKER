import 'package:corona_tracker/services/common_service.dart';
import 'package:corona_tracker/shared/constants.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final List<dynamic> areas;
  const Details({this.areas});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    widget.areas.sort((a, b) => a['displayName'].compareTo(b['displayName']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: COLOR_APP_BAR,
      ),
      body: widget.areas.length != 0
          ? Container(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.areas?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.areas[index]['displayName'] ?? ''),
                    trailing: Text(convertToCommaSep(
                            widget.areas[index]['totalConfirmed'].toString()) ??
                        ''),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            )
          : Center(
              child: Text('No Data Available'),
            ),
    );
  }
}
