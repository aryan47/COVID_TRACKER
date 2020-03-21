import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

Future apis(DatabaseReference databaseReference) async {
  final response = await databaseReference.once();
  return response.value;
}

Future count(String url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future news(String url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String data =
        response.body.toString().replaceFirst('liveBlogTypeALL (', '');
    data = data.substring(0, data.length - 1);
    return json.decode(data);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
