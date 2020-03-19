import 'package:corona_tracker/controller/common_controller.dart';


Future fetchCount() async {
  final result = await count();
  return result;
}

Future fetchNews() async {
  final result = await news();
  return result;
}
