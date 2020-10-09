/*
 * get_user_store.g.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GetUserStore on _GetUserStore, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_GetUserStore.hasErrors'))
          .value;

  final _$userAtom = Atom(name: '_GetUserStore.user');

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

  final _$errorMessageAtom = Atom(name: '_GetUserStore.errorMessage');

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

  final _$getUserFutureAtom = Atom(name: '_GetUserStore.getUserFuture');

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

  final _$getUserAsyncAction = AsyncAction('_GetUserStore.getUser');

  @override
  Future<dynamic> getUser(String id, CancelToken cancelToken) {
    return _$getUserAsyncAction.run(() => super.getUser(id, cancelToken));
  }

  @override
  String toString() {
    return '''
user: ${user},
errorMessage: ${errorMessage},
getUserFuture: ${getUserFuture},
hasErrors: ${hasErrors}
    ''';
  }
}
