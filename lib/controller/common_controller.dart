import 'dart:convert';
import 'package:http/http.dart' as http;

Future count() async {
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

Future news() async {
  final response = await http.get(
      "https://economictimes.indiatimes.com/etstatic/liveblogs/msid-74701965,callback-liveBlogTypeALL-1.htm");
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
