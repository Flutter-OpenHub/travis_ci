import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:travis_ci/api/account.dart';
import 'package:travis_ci/models/user.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final UserAccountApi _userAccountApi = UserAccountApi();
  @observable
  User user;

  @observable
  String errorMessage = '';

  @observable
  ObservableFuture<User> syncAccountFuture;

  @observable
  ObservableFuture<User> getUserFuture;

  @computed
  bool get hasApiError => errorMessage.isNotEmpty;

  @computed
  bool get hasErrors => user != null;

  @action
  Future getUser(String token, CancelToken cancelToken) async {
    print('a');
    final future = _userAccountApi.getUser(token, cancelToken);
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
  void setUser(User value) {
    user = value;
  }

  @action
  Future syncAccount(String token, CancelToken cancelToken) async {
    final future =
        _userAccountApi.syncAccount(token, user.id.toString(), cancelToken);
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
