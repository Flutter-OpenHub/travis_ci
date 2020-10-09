/*
 * openhub_logo.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:flutter/material.dart';
import 'package:travis_ci/utils/open_url.dart';

/// Flutter OpenHub logo
class OpenHubLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
              size: 40.0,
            ),
            Text(
              'OpenHub',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () {
        OpenUrl.launchURL("https://github.com/Flutter-OpenHub");
      },
    );
  }
}
