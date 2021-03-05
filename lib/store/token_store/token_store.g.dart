// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TokenStore on _TokenStore, Store {
  Computed<String>? _$authorizationTokenComputed;

  @override
  String get authorizationToken => (_$authorizationTokenComputed ??=
          Computed<String>(() => super.authorizationToken,
              name: '_TokenStore.authorizationToken'))
      .value;

  final _$tokenAtom = Atom(name: '_TokenStore.token');

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

  @override
  String toString() {
    return '''
token: ${token},
authorizationToken: ${authorizationToken}
    ''';
  }
}
