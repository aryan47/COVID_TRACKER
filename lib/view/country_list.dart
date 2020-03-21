
import 'package:flutter/material.dart';

class Country extends StatefulWidget {
  List<dynamic> country;
  Country({this.country});

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.country.sort((a,b)=> a.compareTo(b));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country'),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: widget.country.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(widget.country[index]),
              onTap: (){
                Navigator.pop(context, widget.country[index]);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.black);
          },
          
        ),
      ),
    );
  }
}
