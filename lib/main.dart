import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travis_ci/pages/ci_selection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Travis CI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Quicksand'),
      home: InitializationPage(),
    );
  }
}
