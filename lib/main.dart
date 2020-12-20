/*
 * main.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/ci_selection.dart';
import 'store/main_store/main_store.dart';

void main() async {
  mainStore = MainStore();
  WidgetsFlutterBinding.ensureInitialized();
  mainStore.prefs = await SharedPreferences.getInstance();
  mainStore.brightness = (mainStore.prefs.getBool("isDark") ?? false)
      ? Brightness.dark
      : Brightness.light;
  runApp(TravisCI());
}

MainStore mainStore;

class TravisCI extends StatefulWidget {
  @override
  _TravisCIState createState() => _TravisCIState();
}

class _TravisCIState extends State<TravisCI> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Observer(
        builder: (_) => MaterialApp(
              title: 'Travis CI',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.teal,
                  fontFamily: 'SourceSansPro',
                  brightness: mainStore.brightness ?? Brightness.light),
              home: InitializationPage(),
            ));
  }
}
