/*
 * restart_cancel_store.dart
 *
 * Created by Amit Khairnar on 08/12/2020.
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../api/travis_ci_api.dart';

part 'restart_cancel_store.g.dart';

class RestartCancelBuildStore = _RestartCancelBuildStore
    with _$RestartCancelBuildStore;

abstract class _RestartCancelBuildStore with Store {
  final TravisCIApi _travisCIApi = TravisCIApi();

  @observable
  Map data;

  @observable
  String errorMessage = '';

  @observable
  ObservableFuture<Map> restartCancelBuildFuture;

  @computed
  bool get hasErrors => errorMessage.isNotEmpty;

  @action
  Future restartCancelBuild(
      String id, bool isRestart, CancelToken cancelToken) async {
    final future = _travisCIApi.restartCancelBuild(id, isRestart, cancelToken);
    restartCancelBuildFuture = ObservableFuture(future);
    future.then((value) {
      data = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }
}
