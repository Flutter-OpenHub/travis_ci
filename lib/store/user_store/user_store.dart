/*
 * user_store.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../api/travis_ci_api.dart';
import '../../models/user.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final TravisCIApi _userAccountApi = TravisCIApi();
  @observable
  User? user;

  @observable
  String errorMessage = '';

  @observable
  ObservableFuture<User>? syncAccountFuture;

  @observable
  ObservableFuture<User>? getUserFuture;

  @computed
  bool get hasApiError => errorMessage.isNotEmpty;

  @computed
  bool get hasErrors => user != null;

  @action
  Future getUser(CancelToken cancelToken) async {
    final future = _userAccountApi.getUser(cancelToken);
    getUserFuture = ObservableFuture(future);
    future.then((value) {
      user = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }

  @action
  Future syncAccount(CancelToken cancelToken) async {
    final future =
        _userAccountApi.syncAccount(user!.id.toString(), cancelToken);
    syncAccountFuture = ObservableFuture(future);
    future.then((value) {
      user = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }
}
