import 'package:flutter/material.dart';

class Country extends StatefulWidget {
  List<dynamic> country;
  Country({this.country});

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.country.sort((a, b) => a.compareTo(b));
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country'),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: "Search Country"),
              ),
            ),
          ),
          Positioned(
            top: 70,
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: widget.country.length,
              itemBuilder: (BuildContext context, int index) {
                if (_searchText.isEmpty ||
                    (_searchText.isNotEmpty &&
                        widget.country[index]
                            .toString()
                            .toLowerCase()
                            .contains(_searchText.trim().toLowerCase()))) {
                  return ListTile(
                    title: Text(widget.country[index]),
                    onTap: () {
                      Navigator.pop(context, widget.country[index]);
                    },
                  );
                } else {
                  return Container();
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
