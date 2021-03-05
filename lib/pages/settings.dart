/*
 * settings.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:dio/dio.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../init/init.dart';
import '../main.dart';
import '../store/settings_store/settings_store.dart';
import '../utils/open_url.dart';
import '../widgets/openhub_logo.dart';

class SettingsPage extends StatefulWidget {
  final bool showAppBar;

  const SettingsPage({Key? key, required this.showAppBar}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsStore _settingsStore = SettingsStore();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late ReactionDisposer _updateBuildEmailsDisposer;
  late ReactionDisposer _updatePrivateInsightsDisposer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Colors.white,
      appBar: widget.showAppBar
          ? AppBar(
              title: Text(
                'Settings',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontFamily: 'SourceSansPro'),
              ),
              textTheme: TextTheme(headline6: TextStyle(fontSize: 20.0)),
              elevation: 0.0,
            )
          : null,
      body: _buildUI(),
    );
  }

  @override
  void dispose() {
    _updateBuildEmailsDisposer();
    _updatePrivateInsightsDisposer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _settingsStore.loadPrefs();
    _settingsStore.getPreferences(CancelToken());
    _updateBuildEmailsDisposer = reaction(
      (_) => _settingsStore.updateSettingsFuture!.status,
      (result) => _settingsStore.updateSettingsFuture!.status ==
                  FutureStatus.rejected &&
              _settingsStore.hasErrors
          ? _showError()
          : _settingsStore.updateSettingsFuture!.status ==
                      FutureStatus.fulfilled &&
                  !_settingsStore.hasErrors
              ? _saveEmailPrefs()
              : null,
    );

    _updatePrivateInsightsDisposer = reaction(
      (_) => _settingsStore.updatePrivateInsightsFuture!.status,
      (result) => _settingsStore.updatePrivateInsightsFuture!.status ==
                  FutureStatus.rejected &&
              _settingsStore.hasErrors
          ? _showError()
          : _settingsStore.updatePrivateInsightsFuture!.status ==
                      FutureStatus.fulfilled &&
                  !_settingsStore.hasErrors
              ? _savePrivateInsightsPrefs()
              : null,
    );
  }

  _buildUI() {
    return Observer(
        builder: (_) => _settingsStore.getPreferencesFuture!.status ==
                FutureStatus.fulfilled
            ? ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: <Widget>[
                  Observer(
                      builder: (_) => _settingsStore.updateSettingsFuture ==
                                  null ||
                              (_settingsStore.updateSettingsFuture != null &&
                                  (_settingsStore
                                              .updateSettingsFuture!.status ==
                                          FutureStatus.fulfilled ||
                                      _settingsStore
                                              .updateSettingsFuture!.status ==
                                          FutureStatus.rejected))
                          ? SwitchListTile(
                              value: _settingsStore.buildEmails,
                              title: Text(
                                'Build notifications',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              onChanged: (bool value) {
                                _settingsStore.updateEmailSettings(
                                    value, CancelToken());
                              },
                              subtitle: Text(
                                  'The status of your builds straight to your inbox'),
                              secondary: Icon(Icons.notifications),
                            )
                          : ListTile(
                              leading: Icon(Icons.notifications),
                              trailing: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0),
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Build notifications',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                  'The status of your builds straight to your inbox'),
                            )),
                  SwitchListTile(
                    secondary: Icon(Icons.color_lens),
                    title: Text("Dark Theme"),
                    onChanged: (value) => mainStore.toggleTheme(),
                    value: mainStore.brightness == Brightness.dark,
                  ),
                  if (!isOrg)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Insights Visibility Settings',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          leading: Icon(Icons.visibility),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(245, 251, 251, 1.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RadioListTile<String>(
                                value: "private",
                                groupValue:
                                    _settingsStore.privateInsightsVisibility,
                                onChanged: (value) => _settingsStore
                                    .privateInsightsVisibility = value!,
                                title: Text(
                                  "Do not allow everyone to see insights from your private builds",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 14.0),
                                ),
                              ),
                              RadioListTile<String>(
                                value: "public",
                                groupValue:
                                    _settingsStore.privateInsightsVisibility,
                                onChanged: (value) => _settingsStore
                                    .privateInsightsVisibility = value!,
                                title: Text(
                                  "Allow everyone to see insights from your private builds",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 14.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 28.0, top: 8.0, bottom: 16.0),
                                child: _settingsStore
                                                .updatePrivateInsightsFuture ==
                                            null ||
                                        (_settingsStore
                                                    .updatePrivateInsightsFuture !=
                                                null &&
                                            (_settingsStore
                                                        .updatePrivateInsightsFuture!
                                                        .status ==
                                                    FutureStatus.fulfilled ||
                                                _settingsStore
                                                        .updatePrivateInsightsFuture!
                                                        .status ==
                                                    FutureStatus.rejected))
                                    ? Material(
                                        child: InkWell(
                                          onTap: () {
                                            _settingsStore
                                                .updatePrivateInsightsVisibility(
                                                    CancelToken());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                                horizontal: 16.0),
                                            child: Text(
                                              "SAVE",
                                              style: TextStyle(
                                                  color: Colors.blueGrey),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 24.0,
                                        height: 24.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                        ),
                                      ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  Divider(
                    indent: 16.0,
                    endIndent: 16.0,
                  ),
                  ListTile(
                    leading: Icon(Icons.show_chart),
                    title: Text(
                      'Travis CI Status',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle:
                        Text("Check Travis CI status and incident history"),
                    onTap: () {
                      OpenUrl.launchURL('https://www.traviscistatus.com/');
                    },
                  ),
                  ListTile(
                    leading: Icon(FeatherIcons.github),
                    title: Text(
                      'GitHub repo',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Check out the GitHub repo of this app"),
                    onTap: () {
                      OpenUrl.launchURL(
                          'https://github.com/Flutter-OpenHub/travis_ci');
                    },
                  ),
                  Divider(
                    indent: 16.0,
                    endIndent: 16.0,
                  ),
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
              )
            : _settingsStore.getPreferencesFuture!.status ==
                    FutureStatus.rejected
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_settingsStore.errorMessage),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
  }

  _saveEmailPrefs() async {
    _settingsStore.buildEmails = _settingsStore.buildEmailsResponse!.value;
    _settingsStore.sharedPreferences
        .setBool("notification", _settingsStore.buildEmails);
  }

  _savePrivateInsightsPrefs() async {
    _settingsStore.privateInsightsVisibility =
        _settingsStore.privateInsightsVisibilityResponse!.value;
    _settingsStore.sharedPreferences.setString(
        "private_insights", _settingsStore.privateInsightsVisibility);
  }

  _showError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_settingsStore.errorMessage),
      behavior: SnackBarBehavior.floating,
    ));
    _settingsStore.errorMessage = '';
  }
}
