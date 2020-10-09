/*
 * settings.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../store/form_store/form_store.dart';
import '../utils/open_url.dart';
import '../widgets/openhub_logo.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool notification = false;

  final FormStore store = FormStore();

  String currentLocale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Quicksand'),
        ),
        textTheme: TextTheme(headline6: TextStyle(fontSize: 20.0)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            value: notification,
            title: Text(
              'Build notifications',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onChanged: (bool value) {
              setState(() {
                notification = value;
                _updateSettings(store.token, value);
              });
              _savePrefs(notification);
              print(value);
            },
            subtitle: Text('The status of your builds straight to your inbox'),
            secondary: Icon(Icons.notifications),
          ),
          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text(
              'Travis CI status',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              OpenUrl.launchURL('https://www.traviscistatus.com/');
            },
          ),
          Divider(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Text(
                  "Developed by",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16.0,
                ),
                OpenHubLogo()
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  _loadPrefs() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      notification = (prefs.getBool('notification') ?? false);
    });
  }

  _savePrefs(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("notification", value);
  }

  _updateSettings(String travisToken, bool value) async {
    var response = await http.patch(
        "https://api.travis-ci.org/preference/build_emails",
        headers: {"Travis-API-Version": "3", "Authorization": "$travisToken"},
        body: {"value": "$value"});
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonBody = json.decode(responseBody);
      print(jsonBody);
    } else {
      print('Failed!');
      print('Reverting back');
      print('Response code: ${response.statusCode}');
      setState(() {
        notification = !value;
      });
    }
  }
}
