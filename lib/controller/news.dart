import 'dart:convert';
import 'package:http/http.dart' as http;

Future news() async {
  final response = await http.get(
      "https://www.bing.com/covid/data?IG=48FC2DBDE6EA4AEFABCDF500DE923B70");
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
