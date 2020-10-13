/*
 * settings_store.dart
 *
 * Created by Amit Khairnar on 13/10/2020.
 */

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/travis_ci_api.dart';
import '../../models/build_emails_response.dart';
import '../../models/private_insights_visibility.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TravisCIApi _travisCIApi = TravisCIApi();

  SharedPreferences sharedPreferences;

  @observable
  bool buildEmails = false;

  @observable
  String privateInsightsVisibility = "private";

  @observable
  BuildEmailsResponse buildEmailsResponse;

  @observable
  PrivateInsightsVisibilityResponse privateInsightsVisibilityResponse;

  @observable
  String errorMessage = '';

  @observable
  ObservableFuture<BuildEmailsResponse> updateSettingsFuture;

  @observable
  ObservableFuture<PrivateInsightsVisibilityResponse>
      updatePrivateInsightsFuture;

  @observable
  ObservableFuture<List<dynamic>> getPreferencesFuture;

  @computed
  bool get hasErrors => errorMessage.isNotEmpty;

  @action
  Future getPreferences(CancelToken cancelToken) async {
    final future = _travisCIApi.getPreferences(cancelToken);
    getPreferencesFuture = ObservableFuture(future);
    future.then((value) {
      buildEmails = value.singleWhere(
          (element) => element.containsValue("build_emails"))['value'];
      privateInsightsVisibility = value.singleWhere((element) =>
          element.containsValue("private_insights_visibility"))['value'];
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }

  void loadPrefs() async {
    sharedPreferences = await _prefs;
    buildEmails = sharedPreferences.getBool('notification') ?? false;
    privateInsightsVisibility =
        sharedPreferences.getString('private_insights') ?? "private";
  }

  @action
  Future updateEmailSettings(bool value, CancelToken cancelToken) async {
    final future = _travisCIApi.updateBuildEmails(value, cancelToken);
    updateSettingsFuture = ObservableFuture(future);
    future.then((value) {
      buildEmailsResponse = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }

  @action
  Future updatePrivateInsightsVisibility(CancelToken cancelToken) async {
    final future = _travisCIApi.updatePrivateInsightVisibility(
        privateInsightsVisibility, cancelToken);
    updatePrivateInsightsFuture = ObservableFuture(future);
    future.then((value) {
      privateInsightsVisibilityResponse = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }
}
