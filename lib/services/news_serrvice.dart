import 'package:corona_tracker/controller/news.dart';

Future fetchNews() async {
  final result = await news();
  return result;
}
