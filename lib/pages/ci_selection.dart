import 'package:flutter/material.dart';
import 'package:travis_ci/utils/dialog.dart';
import 'package:travis_ci/pages/ci_login.dart';

class InitializationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 150.0),
            child: Image.asset(
              'assets/TravisCI-Full-Color.png',
              width: MediaQuery.of(context).size.width * 0.6,
              //height: 50.0,
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
                      child: Text(
                        'Select CI Server',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22.0),
                      )),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginPage()));
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
