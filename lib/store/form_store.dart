import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:travis_ci/api/auth_user.dart';
import 'package:travis_ci/models/user.dart';
import 'package:travis_ci/store/form_error_store.dart';
import 'package:travis_ci/store/user_store.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final FormErrorState errorState = FormErrorState();
  final UserStore userStore = UserStore();
  final AuthUser _authUser = AuthUser();

  final CancelToken cancelToken = CancelToken();

  @observable
  String token = '';

  @observable
  String errorMessage = '';

  List<ReactionDisposer> _disposers;

  @observable
  ObservableFuture<User> authUserFuture;

  @computed
  bool get hasError => errorMessage.isNotEmpty;

  @action
  Future authUser() async {
    final future = _authUser.authUser(token, cancelToken);
    authUserFuture = ObservableFuture(future);
    future.then((value) {
      userStore.user = value;
    }).catchError((error) {
      errorMessage = error.response != null
          ? error.response.toString()
          : error.message.toString();
    });
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void setupValidations() {
    _disposers = [
      reaction((_) => token, validateToken),
    ];
  }

  void validateAll() {
    validateToken(token);
  }

  @action
  void validateToken(String value) {
    errorState.token = isNull(value) || value.isEmpty
        ? 'Enter token'
        : value.length < 22 ? 'Token is too short' : null;
  }
}
