/*
 * logs_store.dart
 *
 * Created by Amit Khairnar on 11/10/2020.
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../api/travis_ci_api.dart';

part 'logs_store.g.dart';

class LogsStore = _LogsStore with _$LogsStore;

abstract class _LogsStore with Store {
  final TravisCIApi _buildsApi = TravisCIApi();

  @observable
  Map? buildLog;

  @observable
  String? buildLogTxt;

  @observable
  String errorMessage = '';

  @observable
  ObservableFuture<Map>? getBuildLogFuture;

  @observable
  ObservableFuture<String>? getBuildLogTxtFuture;

  @computed
  bool get hasErrors => errorMessage.isNotEmpty;

  @action
  Future getBuildLog(String id, CancelToken cancelToken) async {
    final future = _buildsApi.getBuildLog(id, cancelToken);
    getBuildLogFuture = ObservableFuture(future);
    future.then((value) {
      buildLog = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }

  @action
  Future getBuildLogTxt(String id, CancelToken cancelToken) async {
    final future = _buildsApi.getBuildLogAsTxt(id, cancelToken);
    getBuildLogTxtFuture = ObservableFuture(future);
    future.then((value) {
      buildLogTxt = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }
}
