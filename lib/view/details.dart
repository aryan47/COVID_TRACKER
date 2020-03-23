
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final List<dynamic> areas;
  const Details({this.areas});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.separated(
          shrinkWrap: true,
            itemCount: widget.areas?.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(widget.areas[index]['displayName'] ?? ''),
                  trailing: Text(widget.areas[index]['totalConfirmed'].toString()??''),
                  );
            }, separatorBuilder: (BuildContext context, int index) { 
              return Divider();
             },),
      ),
    );
  }
}
