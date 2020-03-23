import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String convertToCommaSep(String count) {
  String ans = '';
  int length = count.length;
  int skip = length % 3;
  if (skip > 0) {
    ans = count.substring(0, skip);
  }

  for (int i = 0; i < length ~/ 3; i++) {
    if (skip == 0) {
      if (i != 0) {
        ans += ',';
      }
      ans += count.substring((skip) + 3 * i, (skip) + 3 * (i + 1));
    } else {
      ans +=
          ',' + count.substring((skip - 1) + 3 * i, (skip - 1) + 3 * (i + 1));
    }
  }
  return ans;
}
