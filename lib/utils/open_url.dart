/*
 * open_url.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:url_launcher/url_launcher.dart';

class OpenUrl {
  static launchURL(url) async {
    //print('Opening url: $url');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
