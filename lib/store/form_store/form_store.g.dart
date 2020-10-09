/*
 * form_store.g.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_FormStore.hasError'))
      .value;

  final _$tokenAtom = Atom(name: '_FormStore.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_FormStore.errorMessage');

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

  final _$authUserFutureAtom = Atom(name: '_FormStore.authUserFuture');

  @override
  ObservableFuture<User> get authUserFuture {
    _$authUserFutureAtom.reportRead();
    return super.authUserFuture;
  }

  @override
  set authUserFuture(ObservableFuture<User> value) {
    _$authUserFutureAtom.reportWrite(value, super.authUserFuture, () {
      super.authUserFuture = value;
    });
  }

  final _$authUserAsyncAction = AsyncAction('_FormStore.authUser');

  @override
  Future<dynamic> authUser() {
    return _$authUserAsyncAction.run(() => super.authUser());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void validateToken(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateToken');
    try {
      return super.validateToken(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
token: ${token},
errorMessage: ${errorMessage},
authUserFuture: ${authUserFuture},
hasError: ${hasError}
    ''';
  }
}
