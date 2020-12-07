/*
 * ci_selection.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:flutter/material.dart';

import '../api/api_urls.dart';
import '../init/init.dart';
import '../utils/dialog.dart';
import 'ci_login.dart';

class InitializationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
                child: Text(
                  'Select CI Server',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0),
                )),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  isOrg = true;
                  baseUrl = ApiUrls.orgUrl;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  width: 200.0,
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: 'org',
                          child: Image.asset(
                            'assets/TravisCI-Mascot-1.png',
                            width: 40.0,
                            height: 40.0,
                          )),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text('Travis CI (.org)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0)),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  isOrg = false;
                  baseUrl = ApiUrls.comUrl;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  width: 200.0,
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: 'com',
                          child: Image.asset(
                            'assets/TravisCI-Mascot-2.png',
                            width: 40.0,
                            height: 40.0,
                          )),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text('Travis CI (.com)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0)),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8.0)),
              child: InkWell(
                onTap: () {
                  TravisDialog.showWarning(
                      context: context,
                      text: "This option has been disabled");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  width: 200.0,
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: 'enterprise',
                          child: Image.asset(
                            'assets/TravisCI-Mascot-1.png',
                            width: 40.0,
                            height: 40.0,
                          )),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text('Travis CI Enterprise',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
