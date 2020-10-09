/*
 * user_store.g.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool> _$hasApiErrorComputed;

  @override
  bool get hasApiError =>
      (_$hasApiErrorComputed ??= Computed<bool>(() => super.hasApiError,
              name: '_UserStore.hasApiError'))
          .value;
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors => (_$hasErrorsComputed ??=
          Computed<bool>(() => super.hasErrors, name: '_UserStore.hasErrors'))
      .value;

  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_UserStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$syncAccountFutureAtom = Atom(name: '_UserStore.syncAccountFuture');

  @override
  ObservableFuture<User> get syncAccountFuture {
    _$syncAccountFutureAtom.reportRead();
    return super.syncAccountFuture;
  }

  @override
  set syncAccountFuture(ObservableFuture<User> value) {
    _$syncAccountFutureAtom.reportWrite(value, super.syncAccountFuture, () {
      super.syncAccountFuture = value;
    });
  }

  final _$getUserFutureAtom = Atom(name: '_UserStore.getUserFuture');

  @override
  ObservableFuture<User> get getUserFuture {
    _$getUserFutureAtom.reportRead();
    return super.getUserFuture;
  }

  @override
  set getUserFuture(ObservableFuture<User> value) {
    _$getUserFutureAtom.reportWrite(value, super.getUserFuture, () {
      super.getUserFuture = value;
    });
  }

  final _$getUserAsyncAction = AsyncAction('_UserStore.getUser');

  @override
  Future<dynamic> getUser(CancelToken cancelToken) {
    return _$getUserAsyncAction.run(() => super.getUser(cancelToken));
  }

  final _$syncAccountAsyncAction = AsyncAction('_UserStore.syncAccount');

  @override
  Future<dynamic> syncAccount(CancelToken cancelToken) {
    return _$syncAccountAsyncAction.run(() => super.syncAccount(cancelToken));
  }

  @override
  String toString() {
    return '''
user: ${user},
errorMessage: ${errorMessage},
syncAccountFuture: ${syncAccountFuture},
getUserFuture: ${getUserFuture},
hasApiError: ${hasApiError},
hasErrors: ${hasErrors}
    ''';
  }
}
