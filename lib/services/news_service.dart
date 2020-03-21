import 'package:corona_tracker/controller/common_controller.dart';
import 'package:firebase_database/firebase_database.dart';

Future fetchApis(DatabaseReference databaseReference) async {
  final result = await apis(databaseReference);
  return result;
}

Future fetchCount(String api) async {
  final result = await count(api);
  return result;
}

Future fetchNews(String api) async {
  final result = await news(api);
  return result;
}
